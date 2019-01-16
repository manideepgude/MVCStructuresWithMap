//
//  Constants.swift
//  airborne
//
//  Created by Srinu on 02/02/18.
//  Copyright © 2018 AKInfopark. All rights reserved.
//

import Foundation

    let APP_DELEGATE = (UIApplication .shared .delegate as? AppDelegate)!
    //MARK:- APIBaseURL
    public let BASE_CRL = "http://13.126.20.47/app/syfeventomate/"
    //MARK:- APIURL
    public let CollectedData       = "departments/loadDepartments.php"
    public let SubDepartmentsData  = "departments/loadSubDepartments.php"
    public let LifeCykul           = "http://13.126.20.47/app/lifeCykul/webservice/V3.1.3/home.php"
    //MARK:- HTTPMethod
    public let HTTPGET = "GET"
    public let HTTPPOST = "POST"
    public let HTTPPUT = "PUT"
    public let HTTPDELETE = "DELETE"


