//
//  Classes.swift
//  RyanairCodeTest
//
//  Created by Shashank Chandran on 10/4/20.
//  Copyright © 2020 Shashank Chandran. All rights reserved.
//

import Foundation
import UIKit

var BaseURL = "https://tripstest.ryanair.com/static/stations.json"
var FlightAvailURL = "https://tripstest.ryanair.com/api/v4/Availability"

//Utilities Class
class Utilities {
    
    //class method for custom alert with message
    class func showAlertControllerWith(title:String, message:String?, onVc:UIViewController , style: UIAlertController.Style = .alert, buttons:[String], completion:((Bool,Int)->Void)?) -> Void {
        
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: style)
        for (index,title) in buttons.enumerated() {
            let action = UIAlertAction.init(title: title, style: UIAlertAction.Style.default) { (action) in
                completion?(true,index)
            }
            alertController.addAction(action)
        }
        
        onVc.present(alertController, animated: true, completion: nil)
    }
    
    //Class method to convert UTC date string to readable date format
    class func convertReadableDateString(_ dateString: String) -> String? {
        
        let serverDateFormatter = DateFormatter()
        serverDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let responseDate = serverDateFormatter.date(from: dateString) else {
            print ("Error in response Date ")
            return nil
        }
        
        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = "MMM dd yyyy h:mm a"
        
        return resultFormatter.string(from: responseDate)
    }
    
    
    
    
    
}


//Extention for UITextField for datePicker
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.year = +1
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 213))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        //Setting minimum date to Current date
        datePicker.minimumDate = currentDate
        //Setting Maximum date to exact one year from today
        datePicker.maximumDate = calendar.date(byAdding: dateComponents, to: currentDate)
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 42.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(Cancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func Cancel() {
        self.resignFirstResponder()
    }
    
}

extension UIView{
    func showBlurLoader(){
        DispatchQueue.main.async {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            activityIndicator.color = #colorLiteral(red: 0.02745098039, green: 0.2078431373, blue: 0.5647058824, alpha: 1)
            activityIndicator.startAnimating()
            blurEffectView.contentView.addSubview(activityIndicator)
            activityIndicator.center = blurEffectView.contentView.center
            self.addSubview(blurEffectView)
        }
    }
    
    func removeBluerLoader(){
        DispatchQueue.main.async {
            self.subviews.flatMap {  $0 as? UIVisualEffectView }.forEach {
                $0.removeFromSuperview()
            }
        }
    }
}





