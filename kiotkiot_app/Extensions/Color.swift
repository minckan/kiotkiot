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
    
    static var sunnyGradient1: UIColor {
        return UIColor.rgb(251, 216, 134, 1)
    }
    
    static var sunnyGradient2: UIColor {
        return UIColor.rgb(247, 121, 125, 1)
    }
    
    static var rainGradient1: UIColor {
        return UIColor.rgb(94, 130, 230, 1)
    }

    static var rainGradient2: UIColor {
        return UIColor.rgb(206, 220, 245, 1)
    }
    
    static var cloudyGradient1: UIColor {
        return UIColor.rgb(117, 127, 154, 1)
    }

    static var cloudyGradient2: UIColor {
        return UIColor.rgb(215, 221, 232, 1)
    }
    
//    static var cloudyGradient1: UIColor {
//        return UIColor.rgb(167, 157, 191, 1)
//    }
//
//    static var cloudyGradient2: UIColor {
//        return UIColor.rgb(233, 228, 240, 1)
//    }
    
    static var overcastGradient1: UIColor {
        return UIColor.rgb(189, 195, 199, 1)
    }

    static var overcastGradient2: UIColor {
        return UIColor.rgb(44, 62, 80, 1)
    }
    
    
    static var snowGradient1: UIColor {
        return UIColor.rgb(131, 164, 212, 1)
    }

    static var snowGradient2: UIColor {
        return UIColor.rgb(182, 251, 255, 1)
    }
    
    static var rainSnowGradient1: UIColor {
        return UIColor.rgb(167, 157, 191, 1)
    }

    static var rainSnowGradient2: UIColor {
        return UIColor.rgb(233, 228, 240, 1)
    }

}
