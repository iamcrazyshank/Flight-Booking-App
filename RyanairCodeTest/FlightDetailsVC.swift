//
//  FlightDetailsVCViewController.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/5/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class FlightDetailsVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiCall()
        // Do any additional setup after loading the view.
    }
    
    
  
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getApiCall() {
       
        
        dataRequest(with: "https://tripstest.ryanair.com/api/v4/Availability?origin=DUB&destination=STN&dateout=2020-11-20&datein=2020-11-10&adt=1&teen=0&chd=0&roundtrip=false&ToUs=AGREED&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=3", objectType: FlightDetails.self) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
        
        
    }

    
    

}



