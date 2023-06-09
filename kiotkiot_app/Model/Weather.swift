//
//  Weather.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

struct Weather {
    let weatherImg : UIImage
    var weatherText: String?
    let temperature : String
    var time: String?
    var date: String?
    
    init(weatherData dictionary : Dictionary<String, Any>) {
        self.weatherImg = dictionary["image"] as! UIImage
        self.temperature = dictionary["temperature"] as! String

        if let date = dictionary["date"] {
            self.date = date as? String
        }
        
        if let title = dictionary["title"] {
            self.weatherText = title as? String
        }
        
        if let time = dictionary["time"] {
            self.time = time as? String
        }
    }
}


enum Weathers : String, CaseIterable{
    case sunshine
    case cloudy
    case rainy
}


struct WeatherItem: Codable {
    let weatherCode: String
    let weatherName: String
    let weatherValue: String
    let weatherUnit: String
    
    enum CodingKeys: String, CodingKey {
        case weatherCode = "weather_code"
        case weatherName = "weather_name"
        case weatherValue = "weather_value"
        case weatherUnit = "weather_unit"
    }
}

struct FcsWeather: Codable {
    let fcsDate: String
    let fcsTime: String
    let weather: WeatherItem
    
    enum CodingKeys: String, CodingKey {
        case fcsDate = "fcs_date"
        case fcsTime = "fcs_time"
        case weather = "weather"
    }
}

struct Address: Codable {
    let address: String
    let nx: Double
    let ny: Double
    let latitude: Float
    let longitude: Float
}

struct WeatherInfo: Codable {
    let currentDate: String
    let currentTime: String
    let address: Address?
    let fcsWeathers: [FcsWeather]
    
    enum CodingKeys: String, CodingKey {
        case currentDate = "current_date"
        case currentTime = "current_time"
        case address
        case fcsWeathers = "fcs_weathers"
    }
}

struct ClothingDetails: Codable {
    let title: String?
    let link: String?
    let image: String?
}

struct RecommendationClothing: Codable {
    let jacket: ClothingDetails?
    let hats: ClothingDetails?
    let tops: ClothingDetails?
    let bottoms: ClothingDetails?
    let socks: ClothingDetails?
    let shoes: ClothingDetails?
    let accessories: ClothingDetails?
    
    enum CodingKeys: String, CodingKey {
        case jacket
        case hats
        case tops
        case bottoms
        case socks
        case shoes
        case accessories
    }
}

struct RecommendationModel: Codable {
    let weather: WeatherInfo
    let recommendationDate: String
    let recommendationClothing: RecommendationClothing
    
    enum CodingKeys: String, CodingKey {
        case weather
        case recommendationDate = "recommendation_date"
        case recommendationClothing = "recommendation_clothing"
    }
}

struct Clothings {
    let key: String
    let detail: ClothingDetails
}
