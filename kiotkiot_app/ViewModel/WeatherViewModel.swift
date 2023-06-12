//
//  WeatherViewModel.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/12.
//

import Foundation

struct WeatherViewModel {
    private let weather : FcsWeather
    
    
    init(weather: FcsWeather) {
        self.weather = weather
    }
    
    var timeLabelText : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"

        if let date = formatter.date(from: weather.fcsTime) {
            formatter.dateFormat = "HH:mm"
            let formattedTime = formatter.string(from: date)
            return formattedTime
        } else {
            print("Invalid time format")
            return ""
        }
    }

}
