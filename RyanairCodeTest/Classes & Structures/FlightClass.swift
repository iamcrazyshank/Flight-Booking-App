//
//  FlightClass.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/5/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import Foundation

struct FlightDetails: Codable {
    let termsOfUse: String
    let currency: String
    let trips: [Trip]
    
    enum CodingKeys: String, CodingKey {
        case termsOfUse = "termsOfUse"
        case currency = "currency"
        case trips = "trips"
    }
}

struct Trip: Codable {
    let origin: String
    let originName: String
    let destination: String
    let destinationName: String
    let dates: [DateElement]
    
    enum CodingKeys: String, CodingKey {
        case origin = "origin"
        case originName = "originName"
        case destination = "destination"
        case destinationName = "destinationName"
        case dates = "dates"
    }
}


struct DateElement: Codable {
    let dateOut: String
    let flights: [Flight]
    
    enum CodingKeys: String, CodingKey {
        case dateOut = "dateOut"
        case flights = "flights"
    }
}

struct Flight: Codable {
    let regularFare: RegularFare
    let flightNumber: String
    let time: [String]
    let duration: String
    
    enum CodingKeys: String, CodingKey {
        case regularFare = "regularFare"
        case flightNumber = "flightNumber"
        case time = "timeUTC"
        case duration = "duration"
    }
}

struct RegularFare: Codable {
    let fareKey: String
    let fares: [Fare]
    
    enum CodingKeys: String, CodingKey {
        case fareKey = "fareKey"
        case fares = "fares"
    }
}

struct Fare: Codable {
    let type: String
    let amount: Double
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case amount = "amount"
    }
}
