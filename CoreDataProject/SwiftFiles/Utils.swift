//
//  Utils.swift
//  CollectionView
//
//  Created by MAC BOOK on 19/12/18.
//  Copyright © 2018 Cykul Cykul. All rights reserved.
//

import Foundation
class Utils {
    func nullConditionForDictionary(dict : Any) -> Dictionary<String, Any> {
        if let value = dict as? Dictionary<String, Any> {
            return value
        }else{
            return [:]
        }
    }
}
