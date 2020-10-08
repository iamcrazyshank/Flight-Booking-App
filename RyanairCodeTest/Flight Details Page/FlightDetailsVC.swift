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
    let FLightCellNib = "flightCell"
    
    var QueryParams = [String : String]()
    
    var FlightList = [FlightDetails]()
    
    @IBOutlet weak var flightDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getApiCall()
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
    
    private func getApiCall() {
        self.view.showBlurLoader()
        NetworkCallClass.dataRequest(with: FlightAvailURL, objectType: FlightDetails.self, params: QueryParams) { (result: Result) in
            switch result {
            case .success(let object):
                DispatchQueue.main.async {
                    self.view.removeBluerLoader()
                    self.FlightList = [object]
                    if self.FlightList[0].trips[0].dates[0].flights.count == 0{
                        Utilities.showAlertControllerWith(title: "Sorry", message: "No flights between the choosen cities", onVc: self, buttons: ["Back"]) { (succes, index) in
                            if index == 0 {
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                    }
                    self.flightDetailsTableView.reloadData()
                }
                
            case .failure(let error):
                 DispatchQueue.main.async {
                self.view.removeBluerLoader()
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
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.FlightList[0].trips[0].dates[0].flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightCellID, for: indexPath) as! flightCell
        cell.selectionStyle = .none
        cell.dateLabel.text = Utilities.convertReadableDateString( self.FlightList[0].trips[0].dates[0].flights[indexPath.row].time[0])
        cell.fareLabel.text = String(self.FlightList[0].trips[0].dates[0].flights[indexPath.row].regularFare.fares[0].amount) + String(self.FlightList[0].currency)
        cell.flightNumLabel.text = String(self.FlightList[0].trips[0].dates[0].flights[indexPath.row].flightNumber)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    

}



