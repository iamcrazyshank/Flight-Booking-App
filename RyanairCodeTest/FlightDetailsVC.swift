//
//  FlightDetailsVCViewController.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/5/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class FlightDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    
    
    let FlightCellID = "flightcell"
    let FLightCellNib = "FlightCell"
    
    var QueryParams = [String : String]()
    
    @IBOutlet weak var flightDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiCall()
        self.flightDetailsTableView.register(UINib.init(nibName: FLightCellNib, bundle: nil), forCellReuseIdentifier: FlightCellID)
        self.flightDetailsTableView.dataSource = self
        self.flightDetailsTableView.delegate = self
        
        self.flightDetailsTableView.rowHeight = UITableView.automaticDimension
        self.flightDetailsTableView.separatorColor = #colorLiteral(red: 0.3412463963, green: 0.1215836629, blue: 0.6041584611, alpha: 1)
        self.flightDetailsTableView.tintColor = #colorLiteral(red: 0.3412463963, green: 0.1215836629, blue: 0.6041584611, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getApiCall() {
        
        NetworkCallClass.dataRequest(with: FlightAvailURL, objectType: FlightDetails.self, params: QueryParams) { (result: Result) in
            switch result {
            case .success(let object):
                print(object)
            case .failure(let error):
                Utilities.showAlertControllerWith(title: "Error", message: error.localizedDescription, onVc: self, buttons: ["Cancel","Retry"]) { (succes, index) in
                    if index == 0 {
                        self.dismiss(animated: true, completion: nil)
                    }else if index == 1{
                        self.getApiCall()
                    }
                }
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightCellID, for: indexPath) as! FlightCell
        cell.selectionStyle = .none
        return cell
    }
    

}



