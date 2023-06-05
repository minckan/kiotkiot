//
//  Helpers.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit

func getFontName() {
    for family in UIFont.familyNames {
        
        let sName: String = family as String
        print("family: \(sName)")
        
        for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
        }
    }
}
