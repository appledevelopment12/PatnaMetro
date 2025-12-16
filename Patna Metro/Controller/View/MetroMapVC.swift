//
//  MetroMapVC.swift
//  Patna Metro
//
//  Created by Rohit on 22/09/25.
//


    import UIKit
    import MapKit

    // MARK: - Station Model
    struct MetroStation {
        let name: String
        let lat: Double
        let lng: Double
        var lineColors: [UIColor]
    }

    class MetroMapVC: UIViewController {
        
        @IBOutlet weak var mapView: MKMapView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            mapView.delegate = self
            
            // Camera Patna center par
            let center = CLLocationCoordinate2D(latitude: 25.5941, longitude: 85.1376)
            mapView.setRegion(MKCoordinateRegion(center: center,
                                                 span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                        longitudeDelta: 0.1)),
                              animated: false)
            
            // ================= BLUE LINE =================
            let blueStations: [(String, Double, Double)] = [
                ("ISBT", 25.577575077862537, 85.19004620611668),
                ("Zero Mile", 25.58602740703838, 85.18679235130548),
                ("Bhoothnath", 25.58554931447189, 85.17307385802269),
                ("Khemnichak", 25.584785451037387, 85.15928763896227),
                ("Malahi Pakri", 25.593660904597694, 85.15726961195469),
                ("Rajendra Nagar", 25.602597985095137, 85.16523577272892),
                ("Moin-ul-Haq", 25.60884964384219, 85.16655374318361),
                ("University", 25.61735176203031, 85.1706887036562),
                ("PMCH", 25.61998644332994, 85.15711370855568),
                ("Gandhi Maidan", 25.61944197752194, 85.14757040888071),
                ("Aakashwani", 25.61327129241622, 85.13940677046776),
                ("Patna Station", 25.60552778220608, 85.13749971985817)
            ]
            
            let blueCoords = blueStations.map {
                CLLocationCoordinate2D(latitude: $0.1, longitude: $0.2)
            }
            let bluePolyline = MKPolyline(coordinates: blueCoords, count: blueCoords.count)
            bluePolyline.title = "blue"
            mapView.addOverlay(bluePolyline)
            
            // ================= RED LINE =================
            let redStations: [(String, Double, Double)] = [
                ("Khemnichak", 25.584785451037387, 85.15928763896227),
                ("Jaganpura", 25.584147080032704, 85.15352625399828),
                ("Ramkrishan Nagar", 25.584324892857456, 85.14177247881888),
                ("Mithapur", 25.585151658541808, 85.13374496251345),
                ("CNLU", 25.592804564367093, 85.13600975275038),
                ("Patna Junction", 25.603355385346585, 85.1366900280118),
                ("Vidyut Bhawan", 25.610692999884588, 85.1264349371195),
                ("Vikash Bhawan", 25.60606656680052, 85.11512137949467),
                ("Patna Zoo", 25.604068032619427, 85.10051406919956),
                ("Raja Bazar", 25.60474167238148, 85.08738901466131),
                ("Rukanpura", 25.60716347877395, 85.06915770471096),
                ("Patliputra", 25.612807215958433, 85.05537953227757),
                ("RPS Mor", 25.61809606916415, 85.04870619624853),
                ("Saguna Mor", 25.62334538878709, 85.04223302006721),
                ("Danapur Cantt", 25.629059097472886, 85.0413529202342)
            ]
            
            let redCoords = redStations.map {
                CLLocationCoordinate2D(latitude: $0.1, longitude: $0.2)
            }
            let redPolyline = MKPolyline(coordinates: redCoords, count: redCoords.count)
            redPolyline.title = "red"
            mapView.addOverlay(redPolyline)
            
            // ================= MERGE STATIONS =================
            let blueStationsData = blueStations.map { ($0.0, $0.1, $0.2, UIColor.blue) }
            let redStationsData = redStations.map { ($0.0, $0.1, $0.2, UIColor.red) }
            
            let allStations = mergeStations([blueStationsData, redStationsData])
            
            // ================= ADD MARKERS =================
            for station in allStations {
                let annotation = StationAnnotation(station: station)
                mapView.addAnnotation(annotation)
            }
        }
        
        // Merge duplicate stations
        func mergeStations(_ stations: [[(String, Double, Double, UIColor)]]) -> [MetroStation] {
            var uniqueStations: [String: MetroStation] = [:]
            
            for lineStations in stations {
                for (name, lat, lng, color) in lineStations {
                    if var existing = uniqueStations[name] {
                        existing.lineColors.append(color)
                        uniqueStations[name] = existing
                    } else {
                        uniqueStations[name] = MetroStation(name: name, lat: lat, lng: lng, lineColors: [color])
                    }
                }
            }
            return Array(uniqueStations.values)
        }
    }

    // MARK: - Custom Annotation
    class StationAnnotation: NSObject, MKAnnotation {
        let station: MetroStation
        var coordinate: CLLocationCoordinate2D
        var title: String?
        
        init(station: MetroStation) {
            self.station = station
            self.coordinate = CLLocationCoordinate2D(latitude: station.lat, longitude: station.lng)
            self.title = station.name
        }
    }

    // MARK: - Map Delegate
    extension MetroMapVC: MKMapViewDelegate {
        
        // Custom marker
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let stationAnnotation = annotation as? StationAnnotation else { return nil }
            
            let id = "stationMarker"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: id)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: id)
            }
            
            // ---- Container View ----
            let container = UIView()
            container.backgroundColor = .clear
            
            // ---- Circle View ----
            let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            circleView.backgroundColor = .white
            circleView.layer.cornerRadius = 15
            circleView.layer.masksToBounds = true
            
            if stationAnnotation.station.lineColors.count > 1 {
                // Gradient Border for multi-line stations
                let gradient = CAGradientLayer()
                gradient.frame = circleView.bounds
                gradient.colors = stationAnnotation.station.lineColors.map { $0.cgColor }
                gradient.startPoint = CGPoint(x: 0, y: 0.5)
                gradient.endPoint = CGPoint(x: 1, y: 0.5)
                
                let shape = CAShapeLayer()
                shape.lineWidth = 4
                shape.path = UIBezierPath(ovalIn: circleView.bounds.insetBy(dx: 2, dy: 2)).cgPath
                shape.strokeColor = UIColor.black.cgColor
                shape.fillColor = UIColor.clear.cgColor
                gradient.mask = shape
                
                circleView.layer.addSublayer(gradient)
            } else {
                circleView.layer.borderWidth = 4
                circleView.layer.borderColor = stationAnnotation.station.lineColors[0].cgColor
            }
            
            // ---- Center icon ----
            let imageView = UIImageView(image: UIImage(named: "locationdone"))
            imageView.frame = CGRect(x: 8, y: 8, width: 14, height: 14)
            imageView.contentMode = .scaleAspectFit
            circleView.addSubview(imageView)
            
            // ---- Label ----
            let label = UILabel()
            label.text = stationAnnotation.station.name
            label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            label.textColor = .black
            label.textAlignment = .center
            label.backgroundColor = .white
            label.layer.cornerRadius = 6
            label.layer.masksToBounds = true
            label.layer.borderWidth = 0.5
            label.layer.borderColor = UIColor.lightGray.cgColor
            label.sizeToFit()
            label.frame = CGRect(x: 0, y: circleView.frame.maxY + 4,
                                 width: max(70, label.frame.width + 12), height: 22)
            label.center.x = circleView.center.x
            
            // ---- Container size adjust ----
            let width = max(circleView.frame.width, label.frame.width) + 10
            let height = label.frame.maxY + 5
            container.frame = CGRect(x: 0, y: 0, width: width, height: height)
            
            container.addSubview(circleView)
            container.addSubview(label)
            
            // ---- Convert UIView to UIImage ----
            UIGraphicsBeginImageContextWithOptions(container.bounds.size, false, 0)
            container.layer.render(in: UIGraphicsGetCurrentContext()!)
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            view?.image = finalImage
            view?.canShowCallout = false // callout bubble hide
            view?.centerOffset = CGPoint(x: 0, y: -container.bounds.height/2) // adjust anchor
            
            return view
        }

        
        // Polyline renderer
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: polyline)
                if polyline.title == "blue" {
                    renderer.strokeColor = .blue
                } else if polyline.title == "red" {
                    renderer.strokeColor = .red
                }
                renderer.lineWidth = 5
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
