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

public func printWithLabel(label: String, message: Any) {
    print("[\(label)] \(message)")
}

public func printSuccessWithLabel(label: String, message: Any) {
    print("⭐️Success⭐️[\(label)] \(message)")
}

public func printErrorWithLabel(label: String, message: Any) {
    print("❗️Error❗️[\(label)] \(message)")
}

public func saveData(key : String, value: Any) {
    UserDefaults.standard.set(value, forKey: String(key))
}

public func getData(key:String) -> String? {

    return  UserDefaults.standard.string(forKey: key)
}
