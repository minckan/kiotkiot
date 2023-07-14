//
//  UserService.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/08.
//

import Foundation
import Alamofire

struct UserService {
    static let shared = UserService()
    
    func registerDeviceId(uuid: String, completionHandler: @escaping()->Void, errorHandler: @escaping(String) -> ()) {
        let url = BASE_API_URL + "/user/register/me"
        let params = ["device_id" : uuid] as Dictionary

        
        AF.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
                
            case .success(_):
                completionHandler()
            case .failure(let error):
                errorHandler(error.localizedDescription)
            }
        }
    }
    

    
    func registerPushData(dictionary: Dictionary<String, String>, completionHandler: @escaping()->Void, errorHandler: @escaping(String) -> ()) {
        let url = BASE_API_URL + "/user/register/me/push"
        
        AF.request(
            url,
            method: .post,
            parameters: dictionary,
            encoding: JSONEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
                
            case .success(_):
                completionHandler()
            case .failure(let error):
                errorHandler(error.localizedDescription)
            }
        }
    }
    
    
    func registerInterests(dictionary: Dictionary<String, String>, completionHandler: @escaping()->Void, errorHandler: @escaping(String) -> ()) {
        let url = BASE_API_URL + "/user/register/interesting"
        
        AF.request(
            url,
            method: .post,
            parameters: dictionary,
            encoding: JSONEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            switch response.result {
                
            case .success(_):
                completionHandler()
            case .failure(let error):
                errorHandler(error.localizedDescription)
            }
        }
    }
}
