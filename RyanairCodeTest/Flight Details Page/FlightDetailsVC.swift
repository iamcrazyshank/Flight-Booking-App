//
//  FlightDetailsVCViewController.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/5/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class FlightDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    //Nib Declaration
    let FlightCellID = "flightcell"
    let FLightCellNib = "flightCell"
    
    //Query parameter dictionary
    var QueryParams = [String : String]()
    
    var FlightList = [FlightDetails]()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flightDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFlightDetailsApiCall()
        self.flightDetailsTableView.register(UINib.init(nibName: FLightCellNib, bundle: nil), forCellReuseIdentifier: FlightCellID)
        self.flightDetailsTableView.rowHeight = UITableView.automaticDimension
        self.flightDetailsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.flightDetailsTableView.delegate = self
        self.flightDetailsTableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.FlightList.removeAll()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //method to GET flight details of a date.
    private func getFlightDetailsApiCall() {
        self.view.showBlurLoader()
        NetworkCallClass.dataRequest(with: FlightAvailURL, objectType: FlightDetails.self, params: QueryParams) { (result: Result) in
            switch result {
            case .success(let object):
                DispatchQueue.main.async {
                    // JSON Parsing to FlightList array object
                    self.view.removeBluerLoader()
                    self.FlightList = [object]
                    self.titleLabel.text = self.FlightList[0].trips[0].origin + " To " + self.FlightList[0].trips[0].destination
                    if self.FlightList[0].trips[0].dates[0].flights.count == 0{
                        //Error alert
                        Utilities.showAlertControllerWith(title: "Sorry", message: "No flights currently", onVc: self, buttons: ["Back"]) { (succes, index) in
                            if index == 0 {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                    self.flightDetailsTableView.reloadData()
                }
                
            case .failure(let error):
                 DispatchQueue.main.async {
                    //Error Alert
                self.view.removeBluerLoader()
                Utilities.showAlertControllerWith(title: "Error", message: error.localizedDescription, onVc: self, buttons: ["Cancel","Retry"]) { (succes, index) in
                    if index == 0 {
                        self.dismiss(animated: true, completion: nil)
                    }else if index == 1{
                        self.getFlightDetailsApiCall()
                    }
                 }
                }
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.FlightList[0].trips[0].dates[0].flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightCellID, for: indexPath) as! flightCell
        cell.selectionStyle = .none
        cell.dateLabel.text = Utilities.convertReadableDateString( self.FlightList[0].trips[0].dates[0].flights[indexPath.row].time[0])
        cell.fareLabel.text = "Price :" + String(self.FlightList[0].trips[0].dates[0].flights[indexPath.row].regularFare.fares[0].amount) + " " + String(self.FlightList[0].currency)
        cell.flightNumLabel.text = "FL No. :" +  String(self.FlightList[0].trips[0].dates[0].flights[indexPath.row].flightNumber)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    

}



