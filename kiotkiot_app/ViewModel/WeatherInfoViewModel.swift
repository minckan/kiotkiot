//
//  WeatherInfoModel.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/08.
//

import UIKit

struct WeatherInfoViewModel {
    private let weatherInfo: WeatherInfo
    
    
    init(weatherInfo: WeatherInfo) {
        self.weatherInfo = weatherInfo
    }

    var temperatureList : [FcsWeather] {
        return weatherInfo.fcsWeathers.filter({$0.weather.weatherCode == "T1H"})
    }
    
    var locationLabelText : NSAttributedString? {
        guard let addr = self.weatherInfo.address?.address else {return nil}
        let components = addr.components(separatedBy: " ").filter({!$0.isEmpty})
        let attributedString = NSMutableAttributedString(string: "\(components[1]) \(components[2]) ", attributes: [.font: UIFont(name: FontNeo.bold.rawValue, size: 18) ?? UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.darkText])
        attributedString.append(NSAttributedString(string: components[0], attributes: [.font: UIFont(name: FontNeo.light.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.darkText]))
        
        return attributedString
    }
    
    var temperatureText : String {
        return "\(temperatureList[0].weather.weatherValue)º"
    }
    
    
}
