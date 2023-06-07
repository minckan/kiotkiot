//
//  Color.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit

//extension UIColor {
//    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ aplph: CGFloat) -> UIColor {
//        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: aplph)
//    }
//
//    static let weatherBlue = rgb(66,122,254,1)
//    static let weatherGray = rgb(242,243,247,1)
//    static let darkText = rgb(50, 50, 50, 1)
//}

extension UIColor {
    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIColor {
    static var weatherBlue: UIColor {
        return UIColor.rgb(66, 122, 254, 1)
    }
    
    static var weatherGray: UIColor {
        return UIColor.rgb(242, 243, 247, 1)
    }
    
    static var darkText: UIColor {
        return UIColor.rgb(50, 50, 50, 1)
    }
}
