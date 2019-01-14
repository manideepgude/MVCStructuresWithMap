//
//  RestAPIFile.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 12/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import Foundation
import UIKit

class RestAPI: NSObject
{
    static let sharedInstance = RestAPI()
    
    func restAPIMtd(urlString: String,  methodName: String, params: String = "", CompletionHandler:@escaping (_ success: Bool, _ response: NSDictionary)  -> Void) {
        // create post request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = methodName
        let postData = params.data(using: .utf8)
        request.httpBody = postData
        // insert json data to the request
        request.timeoutInterval = 60
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                self.showErrorMessage(error:(error)!)
                CompletionHandler(false, [:])
                return
            }
            guard let data = data else {
                self.showErrorMessage(error:(error)!)
                CompletionHandler(false, [:])
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    CompletionHandler(true, json as NSDictionary)
                    return
                }
            } catch let error {
                CompletionHandler(false, [:])
                self.showErrorMessage(error: error)
            }
        })
        task.resume()
    }
    
    func showErrorMessage(error:Error) -> Void {
        DispatchQueue.main.async {
           
            print(error.localizedDescription)
        }
    }    }

