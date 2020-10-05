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
    
    func UserPlaceSearch()
}


class SelectAirportVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var cancelButton: UIButton!
    
    let SearchCellID = "stationcell"
    let SearchCellNib = "StationCell"
    @IBOutlet weak var searchBar: UISearchBar!
    
    var Searchdelegate: SearchDelegate? = nil
    
    @IBOutlet weak var searchStationTableView: UITableView!
    
    var StationList = [stations]()
    var filteredData = [stations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStationList()
        self.searchStationTableView.register(UINib.init(nibName: SearchCellNib, bundle: nil), forCellReuseIdentifier: SearchCellID)
        self.searchStationTableView.dataSource = self
        self.searchStationTableView.delegate = self
        self.searchBar.delegate = self
        self.searchStationTableView.rowHeight = UITableView.automaticDimension
        self.searchStationTableView.separatorColor = #colorLiteral(red: 0.3412463963, green: 0.1215836629, blue: 0.6041584611, alpha: 1)
        self.searchBar.tintColor = #colorLiteral(red: 0.3412463963, green: 0.1215836629, blue: 0.6041584611, alpha: 1)

        // Do any additional setup after loading the view.
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
        // self.seachContentTableView.reloadData()
        
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
       searchResultsAPI(query: query)
        
    }
    
    func searchResultsAPI(query : String) {
        print(query)
        filteredData = StationList.filter({($0.country?.contains(query))! || ($0.code?.contains(query))!})
        DispatchQueue.main.async {
            self.searchStationTableView.reloadData()
        }
        print(filteredData)
        
    }
    
    func getStationList() {
        
        guard let stationUrl = URL(string: BaseURL) else { return }
        URLSession.shared.dataTask(with: stationUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let stationJSON = try decoder.decode(Stations.self, from: data)
                self.StationList = stationJSON.stations
                DispatchQueue.main.async {
                self.searchStationTableView.reloadData()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
        
        
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
    
  
    
}

