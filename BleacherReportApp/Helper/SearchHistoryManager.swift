//
//  SearchHistoryManager.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//


import UIKit

class SearchHistoryManager: NSObject {

    static let historyKey = "searchHistory"
    static var history = [String]()
    
    static func save() -> Void {
        UserDefaults.standard.set(history, forKey: historyKey)
        UserDefaults.standard.synchronize()
    }
    
    static func fetch() -> Void {
        if let hitoryArray = UserDefaults.standard.object(forKey: historyKey) as? [String] {
            history = hitoryArray
        }
    }
    
    static func add(text: String) {
        if !history.contains(text) {
            history.append(text)
        }
    }
}
