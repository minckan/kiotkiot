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
    
    let User_API_URL = BASE_API_URL + "/user/register"
    
    
    func registerDeviceId(uuid: String, completionHandler: @escaping()->Void) {
        let url = User_API_URL + "/me"
        let params = ["device_id" : uuid] as Dictionary
        
        Loading.showLoading()
        BaseService.session.request(
            url,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            Loading.hideLoading()
            switch response.result {
                
                
            case .success(_):
                completionHandler()
            case .failure(let error):
                printErrorWithLabel(label: "registerDeviceId", message: error.localizedDescription)
            }
        }
    }
    

    
    func registerPushData(dictionary: Dictionary<String, Any>, completionHandler: @escaping()->Void) {
        let url = User_API_URL + "/me/push"
        
        Loading.showLoading()
        
        BaseService.session.request(
            url,
            method: .post,
            parameters: dictionary,
            encoding: JSONEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
        )
        .validate(statusCode: 200..<300)
        .response { response in
            Loading.hideLoading()
            switch response.result {
                
            case .success(_):
                completionHandler()
            case .failure(let error):
                printErrorWithLabel(label: "registerPushData", message: error.localizedDescription)
            }
        }
    }
    
    
    func registerInterests(dictionary: Dictionary<String, String>, completionHandler: @escaping()->Void, errorHandler: @escaping(String) -> ()) {
        let url = User_API_URL + "/interesting"
        
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
                printErrorWithLabel(label: "registerInterests", message: error.localizedDescription)
            }
        }
    }
}
