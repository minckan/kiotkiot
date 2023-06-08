//
//  WeatherService.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/08.
//

import Foundation
import Alamofire


struct WeatherService {
    static let shared = WeatherService()
    
    func fetchWeatherData(pos: Position, completionHandler: @escaping(WeatherInfo)->Void) {
        let url = BASE_API_URL + "/weather?latitude=\(pos.lat)&longitude=\(pos.lon)"
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate()
        .responseDecodable(of: WeatherInfo.self) { response in
            guard let weatherInfo = response.value else {return}
            completionHandler(weatherInfo)
        }
    }
}

