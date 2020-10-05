//
//  SearchFlightVC.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import UIKit

class SearchFlightVC: UIViewController {
    

    @IBOutlet weak var flightDatePicker: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.flightDatePicker.setInputViewDatePicker(target: self, selector: #selector(DoneButton))
        // Do any additional setup after loading the view.
    }
    
    @objc func DoneButton() {
        if let datePicker = self.flightDatePicker.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.flightDatePicker.text = dateformatter.string(from: datePicker.date)
        }
        self.flightDatePicker.resignFirstResponder() 
    }
    func UserPlaceSearch() {}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
