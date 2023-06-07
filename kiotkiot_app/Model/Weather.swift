//
//  Weather.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

struct Weather {
    let weatherImg : UIImage
    let temperature : Int
    let time: String
    
    init(weatherImg: UIImage, temperature: Int, time: String) {
        self.weatherImg = weatherImg
        self.temperature = temperature
        self.time = time
    }
}


enum Weathers : String, CaseIterable{
    case sunshine
    case cloudy
    case rainy
    
    
}
