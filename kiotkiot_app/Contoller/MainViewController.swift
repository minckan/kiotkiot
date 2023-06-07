//
//  ViewController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit
import SnapKit
import SwiftUI
import Alamofire


class MainViewController: UICollectionViewController {
    // MARK: Properties
    let url = "https://weather-recommendation-backend-jr4xx26f5q-du.a.run.app/weather/?latitude=127.032014&longitude=37.5089772"
   
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        getWeatherData()
        
        configureNavBar()
        configureUI()
        
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Apis
    func getWeatherData() {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"]).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
                
            case .success(let data):
                printDebug(data)
            case .failure(let error):
                printDebug(error)
            }
        }
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
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainViewHeader.identifier)
        collectionView.register(MainViewProductCell.self, forCellWithReuseIdentifier: MainViewProductCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    func configureUI() {
        
        
    }
    
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
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
        button.tintColor = UIColor.darkText
        button.addTarget(self, action: selector, for: .touchUpInside)
        return barItem
    }
    
   

}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainViewHeader.identifier, for: indexPath) as! MainViewHeader
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewProductCell.identifier, for: indexPath) as! MainViewProductCell
        
        if indexPath.row % 2 == 0 {
            
        }
        
        return cell
    }
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 515)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row % 2 != 0 {
//            print(indexPath.row)
//            return CGSize(width: (UIScreen.main.bounds.width - 50) / 2, height: 300)
//        }
        return CGSize(width: (UIScreen.main.bounds.width - 50) / 2, height: 260)
    }

}


extension MainViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY >= 50 {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground() // 배경을 불투명하게 설정
//            appearance.backgroundColor = .white // 배경 색상을 화이트로 설정
//            self.navigationController?.navigationBar.tintColor = .black
//            self.navigationItem.standardAppearance = appearance
//            self.navigationItem.scrollEdgeAppearance = appearance
//            self.navigationItem.compactAppearance = appearance
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            self.navigationItem.title = "kiotkiot"
        } else {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithTransparentBackground()
//            self.navigationController?.navigationBar.standardAppearance = appearance
//            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//            self.edgesForExtendedLayout = UIRectEdge.top
//            self.navigationController?.navigationBar.tintColor = .white
//            self.navigationItem.scrollEdgeAppearance = appearance
//            self.navigationItem.standardAppearance = appearance
//            self.navigationItem.compactAppearance = appearance
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            self.navigationItem.title  = ""
        }
    }
}


