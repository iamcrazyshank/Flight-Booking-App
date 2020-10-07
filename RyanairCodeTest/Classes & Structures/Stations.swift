//
//  Stations.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import Foundation

struct stations: Codable {
    
    var code: String?
    var country: String?
    
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case country = "name"
    }
   
    
}

struct Stations: Codable {
    var stations: [stations]
}

