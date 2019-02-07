//
//  Customer.swift
//  InviteToParty
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import Foundation

// Expected JSON format
// {"latitude": "52.2559432", "user_id": 9, "name": "Jack Dempsey", "longitude": "-7.1048927"}

//I chossed to use Struct cause there is no need to inherit anything and the list is immutable
//so I'm using let instead of var - to change the values I could use mutating or inout
struct Customer: Decodable {
    let userId: Int
    let name: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case longitude
        case latitude
    }
}
