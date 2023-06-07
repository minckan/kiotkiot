//
//  View.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

extension UIView {
    func setGradient(color1: UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 0.1]
        gradient.startPoint = CGPoint(x: 0.0, y: 3.0)
        gradient.endPoint = CGPoint(x: 10.0, y: 4.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
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
