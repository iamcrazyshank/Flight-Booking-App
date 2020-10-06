//
//  NetworkCalls.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/6/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import Foundation

//Enum to generate Errors
enum NetworkCallsError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

// Enum to print success / failure
enum Result<T> {
    case success(T)
    case failure(NetworkCallsError)
}

//Func dataRequest hits a request to Test URL and convert to Decodable Object from the Structure
func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
    
    //create the url with NSURL with string and Session Object
    let dataURL = URL(string: url)!
    let session = URLSession.shared
    let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
    
    //create dataTask
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        
        guard error == nil else {
            completion(Result.failure(NetworkCallsError.networkError(error!)))
            return
        }
        
        guard let data = data else {
            completion(Result.failure(NetworkCallsError.dataNotFound))
            return
        }
        
        do {
            //Decode the object
            let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
            completion(Result.success(decodedObject))
        } catch let error {
            completion(Result.failure(NetworkCallsError.jsonParsingError(error as! DecodingError)))
        }
    })
    
    task.resume()
}


