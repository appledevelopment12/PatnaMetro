//
//  MetroModel.swift
//  Patna Metro
//
//  Created by Rohit on 20/09/25.
//

struct MetroRouteResponse: Codable {
    let start: String
    let end: String
    let routes: [Route]
    let totalRoutes: Int
}

struct Route: Codable {
    let route: [Station]
    let totalStops: Int
    let estimatedTime: Int
    let fare: Int
    let totalLineChanges: Int
}

struct Station: Codable {
    let stationName: String
    let lineName: String
    let isInterchange: Bool
    let changeHere: Bool
    let marker: Bool
}


//
//
//
//{
//    "start": "Patna Zoo",
//    "end": "Mithapur",
//    "routes": [
//        {
//            "route": [
//                {
//                    "stationName": "Patna Zoo",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Vikas Bhawan",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Vidyut Bhawan",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Patna Junction",
//                    "lineName": "Line 1",
//                    "isInterchange": true,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "CNLU",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Mithapur",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                }
//            ],
//            "totalStops": 6,
//            "estimatedTime": 30,
//            "fare": 60,
//            "totalLineChanges": 0
//        },
//        {
//            "route": [
//                {
//                    "stationName": "Patna Zoo",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Vikas Bhawan",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Vidyut Bhawan",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Patna Junction",
//                    "lineName": "Line 1",
//                    "isInterchange": true,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Change here for Line 2",
//                    "lineName": "Line 2",
//                    "isInterchange": true,
//                    "changeHere": true,
//                    "marker": true
//                },
//                {
//                    "stationName": "Akashvani",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Gandhi Maidan",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "PMCH",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "University",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Moin Ul Haq Stadium",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Rajendra Nagar",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Malahi Pakri",
//                    "lineName": "Line 2",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Khemni Chak",
//                    "lineName": "Line 2",
//                    "isInterchange": true,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Change here for Line 1",
//                    "lineName": "Line 1",
//                    "isInterchange": true,
//                    "changeHere": true,
//                    "marker": true
//                },
//                {
//                    "stationName": "Jaganpura",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Ramkrishna Nagar",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                },
//                {
//                    "stationName": "Mithapur",
//                    "lineName": "Line 1",
//                    "isInterchange": false,
//                    "changeHere": false,
//                    "marker": false
//                }
//            ],
//            "totalStops": 15,
//            "estimatedTime": 75,
//            "fare": 150,
//            "totalLineChanges": 2
//        }
//    ],
//    "totalRoutes": 2
//}
