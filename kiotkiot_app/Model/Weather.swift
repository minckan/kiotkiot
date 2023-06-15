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
    
    enum WeatherCode {
        case SKY(code: String)
        case PTY(code: String)
    }
    
    var weatherStatus : Weathers? {
        if weatherCode == "SKY" {
            
            return checkStatusCode(code: WeatherCode.SKY(code: weatherValue))
        }
        if weatherCode == "PTY" {
            return checkStatusCode(code: WeatherCode.PTY(code: weatherValue))
        }
        
        return nil
    }
    

    func checkStatusCode(code: WeatherCode) -> Weathers? {
        switch code {
        case .SKY(code: let code):
            switch code {
            case "1" :
                return Weathers.sunshine
            case "3":
                return Weathers.cloudy
            case "4":
                return Weathers.overcast
            default:
                printDebug("nothing")
                return nil
            }
        case .PTY(code: let code):
            switch code {
            case "0" :
                return nil
            case "1":
                return Weathers.rain
            case "2":
                return Weathers.rainSnow
            case "3":
                return Weathers.snow
            case "5":
                return Weathers.drizzle
            case "6":
                return Weathers.drizzleSnow
            case "7":
                return Weathers.snowfall
            default:
                return nil
            }
        }
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


enum Weathers : String, CaseIterable{
    case sunshine = "sunshine"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case rain = "rain"
    case rainSnow = "rainSnow"
    case snow = "snow"
    case drizzle = "drizzle"
    case drizzleSnow = "drizzleSnow"
    case snowfall = "snowfall"
    
    var description : String  {
        switch self {
        case .sunshine:
            return "오늘은 맑은날"
        case .cloudy:
            return  "구름이 많은 날"
        case .overcast:
            return "흐린 날"
        case .rain:
            return "비오는 날"
        case .rainSnow:
            return "비와 눈이 같이 내려요"
        case .snow:
            return "눈오는 날"
        case .drizzle:
            return "빗방울"
        case .drizzleSnow:
            return "빗방울과 눈이 함께 내려요"
        case .snowfall:
            return "눈이 흩날리는 날이예요"
        }
    }
    

    

    
    var background : BackgroundGradientColorSet {
        switch self {
        case .sunshine:
            return BackgroundGradientColorSet(color1: .sunnyGradient1, color2: .sunnyGradient2)
        case .cloudy:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .overcast:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .rain:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .rainSnow:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .snow:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .drizzle:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .drizzleSnow:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        case .snowfall:
            return BackgroundGradientColorSet(color1: .rainGradient1, color2: .rainGradient2)
        }
    }
}

struct BackgroundGradientColorSet {
    let color1 : UIColor
    let color2 : UIColor
    
    init(color1: UIColor, color2: UIColor) {
        self.color1 = color1
        self.color2 = color2
    }
}
