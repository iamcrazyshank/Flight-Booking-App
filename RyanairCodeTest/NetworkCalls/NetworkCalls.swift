//
//  NetworkCalls.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/6/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

//NetworkCall Class to perform Network Calls

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

class NetworkCallClass {
    //class Method dataRequest hits a request to Test URL and convert to Decodable Object from the Structure
  class func dataRequest<T: Decodable>(with url: String, objectType: T.Type,params: Dictionary<String, String>, completion: @escaping (Result<T>) -> Void) {
        
        let QueryURL = String(queryString(url,params: params)!)
        //create the url with NSURL with string and Session Object
        let dataURL = URL(string: QueryURL)!
        let session = URLSession.shared
        let request = URLRequest(url: dataURL, timeoutInterval: 60)
        
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
                print(error)
                completion(Result.failure(NetworkCallsError.jsonParsingError(error as! DecodingError)))
            }
        })
        
        task.resume()
    }
    
    //class Method to create URL Query String from the dic passed for API Call
  class func queryString(_ value: String, params: [String: String]) -> String? {
        var components = URLComponents(string: value)
        //Maping the components with Key Value Pair
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url?.absoluteString
    }
    

}

