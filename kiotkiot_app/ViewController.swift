//
//  ViewController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit
import SnapKit



class ViewController: UIViewController {
    // MARK: Properties
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "강남구 논현동"
        label.font = UIFont(name: "NanumSquareNeoTTF-eHv", size: 18)
        label.textColor = .darkText
        
        let attributedString = NSMutableAttributedString(string: "강남구 논현동, ", attributes: [.font: UIFont(name: FontNeo.bold.rawValue, size: 18) ?? UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.darkText])
        attributedString.append(NSAttributedString(string: "서울", attributes: [.font: UIFont(name: FontNeo.light.rawValue, size: 16) ?? UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.darkText]))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    private let weatherView = TodaysWeatherView()
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavBar()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Selectors
    @objc func handleSettingButtonTapped() {
        
    }
    
    @objc func handleNotificationButtonTapped() {
        
    }
    
    @objc func handleShareButtonTapped() {
        
    }
    
    @objc func handleRefreshButtonTapped() {
        
    }
    
    // MARK: Helpers
    func configureUI() {
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalTo(view).offset(20)
        }
        
        view.addSubview(weatherView)
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(280)
        }
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.edgesForExtendedLayout = UIRectEdge.top
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        let setting = makeBarButton("setting", selector: #selector(handleSettingButtonTapped))
        let notification = makeBarButton("notification", selector: #selector(handleNotificationButtonTapped))
        let share = makeBarButton("share", selector: #selector(handleShareButtonTapped))
        let refresh = makeBarButton("refresh", selector: #selector(handleRefreshButtonTapped))
        navigationItem.leftBarButtonItems = [setting, notification]
        navigationItem.rightBarButtonItems = [share, refresh]
    }
    
    func makeBarButton(_ imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let barItem = UIBarButtonItem(customView: button)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkText
        button.addTarget(self, action: selector, for: .touchUpInside)
        return barItem
    }
    
   

}

