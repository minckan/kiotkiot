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
    
    let httpHeaders : HTTPHeaders =  ["Content-Type":"application/json", "Accept":"application/json"]
    
    func fetchWeatherData(pos: Position, completionHandler: @escaping(WeatherInfo)->Void) {
        let url = BASE_API_URL + "/weather"
        
        let params : Parameters = [
            "latitude": pos.lat,
            "longitude" : pos.lon
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: params,
            encoding: URLEncoding.queryString,
            headers:httpHeaders
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: WeatherInfo.self) { response in
            
            
            switch response.result {
                
            case .success(_):
                guard let weatherInfo = response.value else {return}
                completionHandler(weatherInfo)
            case .failure(let error):
                printErrorWithLabel(label: "fetchWeatherData", message: error.localizedDescription)
            }
        }
    }
    

    
    func fetchRecommendationCloth(id: String, gender: Gender, pos: Position,
                                          completionHandler: @escaping(RecommendationModel)->Void
    ) {
        
        printDebug("fetchRecommendationCloth")
        let url = BASE_API_URL + "/recommendation/clothing"
        
        let body : Parameters = [
            "device_id" : id,
            "sex": gender.rawValue,
            "coordinate": [
                "latitude": pos.lat,
                "longitude": pos.lon
            ]
        ]

        AF.request(
            url,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: httpHeaders
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RecommendationModel.self) { response in
            
            switch response.result {

            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                printErrorWithLabel(label: "fetchRecommendationCloth", message: error.localizedDescription)
            }
        }
    }
    
    func refreshRecommendationCloth(id: String, gender: Gender, pos: Position,
                                          completionHandler: @escaping(RecommendationModel)->Void
    ) {
        let url = BASE_API_URL + "/recommendation/clothing/refresh"
        
        let body : Parameters = [
            "device_id" : id,
            "sex": gender.rawValue,
            "coordinate": [
                "latitude": pos.lat,
                "longitude": pos.lon
            ]
        ]

        AF.request(
            url,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: httpHeaders
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RecommendationModel.self) { response in
            

            
            switch response.result {

            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                printErrorWithLabel(label: "fetchRecommendationCloth", message: error.localizedDescription)
            }
        }
    }
}

