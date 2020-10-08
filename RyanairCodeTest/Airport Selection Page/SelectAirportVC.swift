//
//  SelectAirportVC.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchDelegate : class {
    
    func StationSearch(Code :String, CountryName:String)
}


class SelectAirportVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var cancelButton: UIButton!
    
    //Xib Nibs
    let SearchCellID = "stationcell"
    let SearchCellNib = "StationCell"
    @IBOutlet weak var searchBar: UISearchBar!
    
    var Searchdelegate: SearchDelegate? = nil
    
    @IBOutlet weak var searchStationTableView: UITableView!
   
    //Object to store server response
    var StationList = [stations]()
    var filteredData = [stations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getStationList()
        self.searchStationTableView.register(UINib.init(nibName: SearchCellNib, bundle: nil), forCellReuseIdentifier: SearchCellID)
        self.searchStationTableView.rowHeight = UITableView.automaticDimension
        self.searchStationTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchStationTableView.delegate = self
        self.searchStationTableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.StationList.removeAll()
        self.filteredData.removeAll()
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //reload() method call after a delay of 0.75 secs
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
        
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
       searchResultsAPI(query: query)
        
    }
    
    func searchResultsAPI(query : String) {
        //Filter the array with only containing searched query
        filteredData = StationList.filter({($0.country?.contains(query))! || ($0.code?.contains(query))!})
        DispatchQueue.main.async {
            self.searchStationTableView.reloadData()
        }
    }
    
    func getStationList() {
        NetworkCallClass.dataRequest(with: BaseURL, objectType: Stations.self, params: [:]) { (result: Result) in
            switch result {
            case .success(let object):
                self.StationList = object.stations
                DispatchQueue.main.async {
                    self.searchStationTableView.reloadData()
                }
            case .failure(let error):
                //error alert
                Utilities.showAlertControllerWith(title: "Error", message: error.localizedDescription, onVc: self, buttons: ["OK"]) { (succes, index) in
                    if index == 0 {
                        
                    }
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            return filteredData.count
        }
        return self.StationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCellID, for: indexPath) as! StationCell
        cell.selectionStyle = .none
        if searchBar.text != "" {
            cell.Scode.text = self.filteredData[indexPath.row].code
            cell.Sname.text = self.filteredData[indexPath.row].country
        }else{
        cell.Scode.text = self.StationList[indexPath.row].code
        cell.Sname.text = self.StationList[indexPath.row].country
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBar.text != "" {
            self.Searchdelegate?.StationSearch(Code :self.filteredData[indexPath.row].code ?? "",CountryName: self.filteredData[indexPath.row].country ?? "")
        }else{
            self.Searchdelegate?.StationSearch(Code :self.StationList[indexPath.row].code ?? "",CountryName: self.StationList[indexPath.row].country ?? "")
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

