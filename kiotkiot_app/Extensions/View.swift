//
//  View.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit


extension UIView {
    func setGradient(_ bg: BackgroundGradientColorSet) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.colors = [color1.cgColor, color2.cgColor]

//        gradient.frame = bounds
//        layer.addSublayer(gradient)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame  = bounds
        let colors: [CGColor] = [
            bg.color2.cgColor,
            bg.color1.cgColor,
            bg.color2.cgColor
        ]
        let changeColors1: [CGColor] = [
            bg.color1.cgColor,
            bg.color2.cgColor,
            bg.color1.cgColor,
        ]
        
        let changeColors2: [CGColor] = [
            bg.color2.cgColor,
            bg.color1.cgColor,
            bg.color2.cgColor,
        ]

        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.2]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 6.0, y: 2.0)
        
        
        let colorAnimation1 = CABasicAnimation(keyPath: "colors")
        colorAnimation1.toValue = changeColors1
        colorAnimation1.duration = 2
        colorAnimation1.autoreverses = true
        colorAnimation1.isRemovedOnCompletion = false
        colorAnimation1.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation1.repeatCount = .infinity
        
        let colorAnimation2 = CABasicAnimation(keyPath: "colors")
        colorAnimation2.toValue = changeColors2
        colorAnimation2.duration = 2
        colorAnimation2.autoreverses = true
        colorAnimation2.isRemovedOnCompletion = false
        colorAnimation2.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation2.repeatCount = .infinity
        
        gradientLayer.add(colorAnimation1, forKey: "colorChangeAnimation")
        gradientLayer.add(colorAnimation1, forKey: "colorChangeAnimation")
        
        
        layer.addSublayer(gradientLayer)
    }
}


func getGradientLayer(bounds : CGRect, colors: [CGColor]) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    //order of gradient colors
    gradient.colors = colors
    // start and end points
    gradient.startPoint = CGPoint(x: 0.0, y: 3.0)
    gradient.endPoint = CGPoint(x: 2.0, y: 4.0)
    return gradient
}

func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    //create UIImage by rendering gradient layer.
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    //get gradient UIcolor from gradient UIImage
    return UIColor(patternImage: image!)
}
