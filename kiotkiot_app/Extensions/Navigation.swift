//
//  Navigation.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit

extension UINavigationController {
    func setupBarAppearance() {
        let appearance = UINavigationBarAppearance()
        // configureWith_______ : 그림자 값을 생성한다
        
        appearance.backgroundColor = .red
        
//        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 18.0),
//                                          .foregroundColor: UIColor.orange]
//        appearance.largeTitleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 35.0),
//                                               .foregroundColor: UIColor.orange]
        
        // 불투명한 색상의 백그라운드 생성 (불투명한 그림자를 한겹을 쌓는다)
//        appearance.configureWithOpaqueBackground()
        // 제거하고 기존의 백그라운드 색상을 사용 (그림자를 제거하고 기존 배경 사용)
//        appearance.configureWithTransparentBackground()
        
        navigationBar.standardAppearance = appearance
//        navigationBar.compactAppearance = appearance
//        navigationBar.scrollEdgeAppearance = appearance
//        navigationBar.isTranslucent = false
//        navigationBar.tintColor = .black
//        navigationBar.prefersLargeTitles = true
        

    }
}


//@available(iOS 13.0, *)
//func customNavBarAppearance() -> UINavigationBarAppearance {
//    let customNavBarAppearance = UINavigationBarAppearance()
//    
//    // Apply a red background.
//    customNavBarAppearance.configureWithTransparentBackground()
////    customNavBarAppearance.backgroundColor = .systemRed
//    
//    // Apply white colored normal and large titles.
//    customNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//    customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//    // Apply white color to all the nav bar buttons.
//    let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
//    barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
//    barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
//    barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
//    barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
//    customNavBarAppearance.buttonAppearance = barButtonItemAppearance
//    customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
//    customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance
//    
//    return customNavBarAppearance
//}
