//
//  PlanYourJournyVC.swift
//  Patna Metro
//
//  Created by Rohit on 20/09/25.
//

import UIKit
import DropDown

class PlanYourJournyVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var fromTxtfld: UITextField!
    @IBOutlet weak var toTxtfld: UITextField!
    @IBOutlet weak var tableList: UITableView!
    
    var routes: [Route] = []
    var metrolist: MetroRouteResponse?
    
    let metroStations = [
        "Patna Zoo","Vikas Bhawan","Vidyut Bhawan","Patna Junction",
        "Akashvani","Gandhi Maidan","PMCH","University",
        "Moin Ul Haq Stadium","Rajendra Nagar","Malahi Pakri",
        "Khemni Chak","Jaganpura","Ramkrishna Nagar","Mithapur"
    ]
    
    let fromDropDown = DropDown()
    let toDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableList.dataSource = self
        fromTxtfld.delegate = self
        toTxtfld.delegate = self
        setupDropDowns()
    }
    
    func setupDropDowns() {
        fromDropDown.anchorView = fromTxtfld
        fromDropDown.dataSource = metroStations
        fromDropDown.selectionAction = { [weak self] index, item in
            self?.fromTxtfld.text = item
        }
        
        toDropDown.anchorView = toTxtfld
        toDropDown.dataSource = metroStations
        toDropDown.selectionAction = { [weak self] index, item in
            self?.toTxtfld.text = item
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == fromTxtfld {
                fromDropDown.show()
            } else if textField == toTxtfld {
                toDropDown.show()
            }
            return false
        }
    
    @IBAction func findRouteBtn(_ sender: UIButton) {
        guard let from = fromTxtfld.text, !from.isEmpty,
              let to = toTxtfld.text, !to.isEmpty else {
            print("Please enter both stations")
            return
        }
        fetchRoute(start: from, end: to)
    }
}
extension PlanYourJournyVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // For now, show stations from first route
        return metrolist?.routes.first?.route.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteCell", for: indexPath)
        
        if let station = metrolist?.routes.first?.route[indexPath.row] {
            // Show only stationName
            cell.textLabel?.text = station.stationName
            cell.detailTextLabel?.text = "Line: \(station.lineName)"
        }
        
        return cell
    }
}

extension PlanYourJournyVC {
    
    func fetchRoute(start: String, end: String) {
        let parameters = [
            "start": start,
            "end": end
        ]
        
        guard let url = URL(string: "https://us-central1-patna-metro-18427.cloudfunctions.net/getRoute") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error serializing JSON: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "No error description")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MetroRouteResponse.self, from: data)
                
                DispatchQueue.main.async {
                    // store routes and reload table
                    self?.metrolist = response
                    self?.routes = response.routes
                    self?.tableList.reloadData()
                }
                
            } catch {
                print("Decoding error: \(error)")
            }
        }
        
        task.resume()
    }
}
