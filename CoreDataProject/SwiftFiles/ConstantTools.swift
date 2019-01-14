//
//  ConstantTools.swift
//  airborne
//
//  Created by Srinu on 02/02/18.
//  Copyright © 2018 AKInfopark. All rights reserved.
//

import Foundation
import MRProgress

class ConstantTools: NSObject {
    static let sharedConstantTool  = ConstantTools();
    var indicatorView = MRProgressOverlayView()
    var isLogin: Bool = false
    
    //MARK:- MRProgressView
    func showsMRIndicatorView(_ view: UIView,text:String = "Loading") {
        indicatorView.removeFromSuperview()
        indicatorView = MRProgressOverlayView()
        indicatorView.mode = .indeterminateSmallDefault
        indicatorView.titleLabelText = text
        view.addSubview(indicatorView)
        indicatorView.show(true)
    }
    
    func hideMRIndicatorView() {
        indicatorView.dismiss(true)
    }
    
        func getTodayString() -> String{
            
            let date = Date()
            let calender = Calendar.current
            let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            
            let year = components.year
            let month = components.month
            let day = components.day
            let hour = components.hour
            let minute = components.minute
            let second = components.second
            
            let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
            
            return today_string
            
        }
    

    
    // MARK: - Downloading Images
    func downloadImgFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    return
                }
            }
            completion(data, response, error)
            }.resume()
    }
    
    func isValidMobileNumber(phoneNumber: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    func convertToArray(_ jsonText: String) -> NSArray {
        var dictonary:NSArray?
        if let data = jsonText.data(using: String.Encoding.utf8) {
            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray
                return dictonary!
            } catch let error as NSError {
                print(error)
            }
        }
        return []
    }
    
    func iconRoundArc(imageView : UIImageView, customColor  : UIColor) -> UIImageView {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true;
        imageView.layer.borderWidth = 1.0;
        imageView.layer.borderColor = customColor.cgColor;
        return imageView
    }
    
   
}

extension UIAlertController {
    static func alertWithTitle(title: String, message: String = "", cancelButtonTitle: String = "", buttonTitle: String="",handler: ((UIAlertAction) -> Void)? = nil,cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancelButtonTitle, style: .default, handler: cancelHandler)
        alertController.addAction(cancel)
        if buttonTitle != ""{
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
            alertController.addAction(action)
        }
        return alertController
    }
}

