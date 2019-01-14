//
//  Constants.swift
//  airborne
//
//  Created by Srinu on 02/02/18.
//  Copyright © 2018 AKInfopark. All rights reserved.
//

import Foundation

//MARK:- APIBaseURL
public let BASE_URL = "http://easemypay.in/airborne_holidays/webservices/"

//MARK:- APIURL
public let LOGIN               = "login"
public let SENDOTP             = "send_otp"
public let REGISTER            = "register"
public let UPDATEACCOUNT       = "update_account"
public let ACCESSORYCATEGORIES = "accessory_categories"
public let GETCATEGORIES       = "get_categories"
public let NOTIFICATION        = "announcements"
public let CHANGEPASSWORD      = "changepassword"
public let VIEWNOTES           = "view_notes"
public let ADDNOTES            = "add_note"
public let VIEWWISHLIST        = "view_wishlist"
public let SEARCHRESULT        = "search_results"
public let GETBRANDS           = "get_brands"
public let GETMODELS           = "get_models"
public let GETACCESSORYBRANDS  = "get_acc_brands"
public let GETACCESSORYCAT     = "get_acc_cat"
public let GETCONTACTS         = "view_contacts"
public let DELETENOTE          = "delete_note"
public let UPDATENOTE          = "update_note"
public let GETIMAGES           = "get_acc_images"
public let GETRESULTS          = "get_results"
public let GETACCESSORYIES     = "get_accessories"
public let ADDWISHLIST         = "add_to_wishlist"
public let REMOVEWISHLIST      = "remove_wishlist"
public let VERIFYOTP           = "verify_otp"

//MARK:- HTTPMethod
public let HTTPGET = "GET"
public let HTTPPOST = "POST"
public let HTTPPUT = "PUT"
public let HTTPDELETE = "DELETE"


public var isLogin: Bool = false
public let IMAGECACHE = NSCache<AnyObject, AnyObject>()
public let DISPATCHQUEUE = DispatchQueue(label: "reverseDomain", attributes: .concurrent, target: .main)
public let DISPATCHGROUP = DispatchGroup()
