//
//  Loading.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/08/02.
//

import UIKit

class Loading {
    static func showLoading() {
        guard let window = UIApplication.shared.windows.last else {return}
        
        let loadingIndicatorView : UIActivityIndicatorView
        
        if let existedView = window.subviews.first(where: {$0 is UIActivityIndicatorView}) as? UIActivityIndicatorView {
            loadingIndicatorView = existedView
        } else {
            loadingIndicatorView = UIActivityIndicatorView(style: .large)
            
            loadingIndicatorView.frame = window.frame
            loadingIndicatorView.color = .gray
            
            window.addSubview(loadingIndicatorView)
        }
        
        loadingIndicatorView.startAnimating()
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else {return}
            
            window.subviews.filter({$0 is UIActivityIndicatorView}).forEach {$0.removeFromSuperview()}
        }
    }
}
