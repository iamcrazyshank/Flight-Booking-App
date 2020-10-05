//
//  SearchFlightVC.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class SearchFlightVC: UIViewController,SearchDelegate {
  
    @IBOutlet weak var sourceStationButton: UIButton!
    
    @IBOutlet weak var destinationStationButton: UIButton!
    
    @IBOutlet weak var flightDatePicker: UITextField!
    @IBOutlet weak var adultCountTextField: UITextField!
    @IBOutlet weak var teenCountTextField: UITextField!
    @IBOutlet weak var childCountTextField: UITextField!
    
    fileprivate let adultCount = ["1", "2", "3","4","5","6"]
    fileprivate let passengerCount = ["0", "1", "2", "3","4","5","6"]
    
    
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()
    let picker3 = UIPickerView()
    var dateOut = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flightDatePicker.setInputViewDatePicker(target: self, selector: #selector(DoneButton))
        // Do any additional setup after loading the view.
        
        picker1.dataSource = self
        picker1.delegate = self
        
        picker2.dataSource = self
        picker2.delegate = self
        
        picker3.dataSource = self
        picker3.delegate = self
        
        self.adultCountTextField.inputView = self.picker1
        self.teenCountTextField.inputView = self.picker2
        self.childCountTextField.inputView = self.picker3
        
        
        
    }
    
    
    
    @objc func DoneButton() {
        if let datePicker = self.flightDatePicker.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.flightDatePicker.text = dateformatter.string(from: datePicker.date)
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.dateOut = dateformatter.string(from: datePicker.date)
            print(self.dateOut)
        }
        self.flightDatePicker.resignFirstResponder() 
    }
    
    
    func StationSearch(Code: String, CountryName: String) {
        DispatchQueue.main.async {
            self.sourceStationButton.setTitle(Code + " " + CountryName , for: .normal)
        }
    }
    
    @IBAction func sourceStationButtonAction(_ sender: Any) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let showAirportVC = storyboard.instantiateViewController(withIdentifier: "SelectAirportVC") as! SelectAirportVC
            showAirportVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            showAirportVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            showAirportVC.Searchdelegate = self
            self.present(showAirportVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func searchFlightsButtonAction(_ sender: Any) {
        
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let showFlightDetailsVC = storyboard.instantiateViewController(withIdentifier: "FlightDetailsVC") as! FlightDetailsVC
            showFlightDetailsVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            showFlightDetailsVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(showFlightDetailsVC, animated: true, completion: nil)
        }

    }
    
}



extension SearchFlightVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1 {
            return adultCount.count
            
        } else if pickerView == picker2{
            return passengerCount.count
        }else{
             return passengerCount.count
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1{
            return self.adultCount[row]
        }else if pickerView == picker2 || pickerView == picker3 {
            return self.passengerCount[row]
        }else{
             return self.passengerCount[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker1{
            self.adultCountTextField.text = self.adultCount[row]
        }else if pickerView == picker2{
            self.teenCountTextField.text = self.passengerCount[row]
        }else{
            self.childCountTextField.text = self.passengerCount[row]
            
        }
    }
}




