//
//  BaseService.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/07/18.
//

import UIKit
import Alamofire

class BaseService {
    static let session: Session = {
           let configuration = URLSessionConfiguration.af.default
           let apiLogger = APIEventLogger()
           return Session(configuration: configuration, eventMonitors: [apiLogger])
       }()
}
