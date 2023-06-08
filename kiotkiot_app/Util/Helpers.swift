//
//  Helpers.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit
import TAKUUID

func createAndGetUUID() -> String? {
    TAKUUIDStorage.sharedInstance().migrate()
    return TAKUUIDStorage.sharedInstance().findOrCreate()
}

func getFontName() {
    for family in UIFont.familyNames {
        
        let sName: String = family as String
        print("family: \(sName)")
        
        for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
        }
    }
}

public func printDebug(_ message: Any) {
    print("DEBUG: \(message)")
}

public func saveData(key : String, value: String) {
    UserDefaults.standard.set(value, forKey: key)
}

public func getData(key:String) {
    UserDefaults.standard.string(forKey: key)
}
