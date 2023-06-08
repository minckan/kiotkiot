//
//  Weather.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

struct Weather {
    let weatherImg : UIImage
//    let weatherText: String?
    let temperature : Int
    let time: String?
    
    init(weatherImg: UIImage, temperature: Int, time: String?) {
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


struct WeatherItem: Decodable {
    let weather_code : String
    let weather_name : String
    let weather_value : String
    let weather_unit : String
}

struct FcsWeather: Decodable {
    let fcs_date : String
    let fcs_time : String
    let weather : WeatherItem
}

struct Address: Decodable {
    let address : String
    let nx : Double
    let ny : Double
    let latitude: Float
    let longitude: Float
}

struct WeatherInfo : Decodable {
    let current_date: String
    let current_time: String
    let address : Address?
    let fcs_weathers : [FcsWeather]
}
