//
//  WebviewController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/09.
//

import UIKit
import WebKit

class WebviewController : UIViewController {
    var webView: WKWebView!
    let urlString : String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.bounds)
        let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
        webView.customUserAgent = userAgent
        
        webView.navigationDelegate = self

        if let urlString = urlString {
            printDebug(urlString)
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            webView.load(request)
        }

        view.addSubview(webView)
    }
    
    init(urlString: String?) {
        self.urlString = urlString
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WebviewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("Https Host : \(challenge.protectionSpace.host)")
        if challenge.protectionSpace.host.contains("g-y-e-o-m"){
            let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            
            completionHandler(.useCredential, urlCredential)
        }else{
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let urlString = webView.url?.absoluteString else {
            return printDebug("error")
        }
        
        printDebug(urlString)
    }
}
