//
//  Stations.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import Foundation

struct Stations: Codable {
    
    var code: String = ""
    var country: String = ""
    var imageUrl: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case code = "countryCode"
        case country = "countryName"
        case imageUrl = "tripCardImageUrl"
    }
   
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(String.self, forKey: .code)
        country = try values.decode(String.self, forKey: .country)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        
    }
}

struct StationsDataStore: Codable {
    var stations: [Stations]
}
