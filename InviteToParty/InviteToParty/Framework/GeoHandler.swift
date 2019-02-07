//
//  GeoHandler.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import Foundation

struct GeoPoint {
    let lat: Double
    let lon: Double
}

//Static class in Swift - Struct with private init OR final class with private init
struct GeoHandler {
    //Prevent to instantiate the GeoHandler
    private init() {
        
    }
    
    //Office coordinates 53.339428, -6.257664.
    static let officeCoord = GeoPoint(lat: 53.339428, lon: -6.257664)
    
    static func officeDistance(lat: Double, lon: Double) -> Double {
        //Calculate the distance between Office and current coord
        let theta = lon - officeCoord.lon
        var dist = sin(deg2rad(deg: lat)) * sin(deg2rad(deg: officeCoord.lat))
        dist += cos(deg2rad(deg: lat)) * cos(deg2rad(deg: officeCoord.lat)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        //60 is the number of minutes in a degree
        //1.1515 number of statute miles in a nautical mile
        dist = dist * 60 * 1.1515
        dist = dist * 1.609344 //Miles to Kms
        return dist
    }
    
    static func officeDistance(lat: String, lon: String) -> Double {
        guard let latD = Double(lat), let lonD = Double(lon) else {
            return 0
        }
        return officeDistance(lat: latD, lon: lonD)
    }
    
    //Converts decimal degrees to radians
    static func deg2rad(deg: Double) -> Double {
        return deg * Double.pi / 180
    }
    
    //Converts radians to decimal degrees
    static func rad2deg(rad: Double) -> Double {
        return rad * 180.0 / Double.pi
    }
}
