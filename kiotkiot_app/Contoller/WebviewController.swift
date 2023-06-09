//
//  WebviewController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/09.
//

import UIKit
import WebKit

class WebviewController : UIViewController,  WKNavigationDelegate {
    var webView: WKWebView!
    let urlString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        
        if let urlString = urlString {
            printDebug(urlString)
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            
            view.addSubview(webView)
        }

    }
    
    init(urlString: String?) {
        self.urlString = urlString
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
