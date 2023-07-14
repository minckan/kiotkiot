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
import TAKUUID
import CoreLocation
import WebKit
import SwiftSoup
import LinkPresentation

class MainViewController: UICollectionViewController {
    // MARK: Properties
    
    private var isAbleToReload = true
    
    private var metaData: LPLinkMetadata = LPLinkMetadata() {
        didSet {
            DispatchQueue.main.async {
                self.shareURLWithMetadata(metadata: self.metaData)
            }
        }
    }
    
    var locationManager = CLLocationManager()
    var uuid: String?
    private var currentPosition:Position? {
        didSet {
            printDebug("position changed! \(currentPosition)")
            getWeatherData()
        }
    }
    private var info : RecommendationModel? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var clothings : [Clothings] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        registerUUID()
        getCurrentPosition()
        
        configureUI()
        configureNavBar()
        setupCollectionView()

        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Apis
    func registerUUID() {
        
        if let id = TAKUUIDStorage.sharedInstance().findOrCreate() {
            saveData(key: Const.shared.UUID, value: id)
            UserService.shared.registerDeviceId(uuid: id) {
                printDebug("registerDeviceId successed! id is \(id)")
            } errorHandler: { error in
                printDebug("error orccured. \(error)")
            }
        } else {
            guard let uuid = createAndGetUUID() else {return}
            printDebug(uuid)
            saveData(key: Const.shared.UUID, value: uuid)
            UserService.shared.registerDeviceId(uuid: uuid) {
                printDebug("registerDeviceId successed!")
            } errorHandler: { error in
                printDebug("error orccured. \(error)")
            }
        }
        
       
    }
    
    
    func getWeatherData() {
        collectionView.refreshControl?.beginRefreshing()
        guard let position = currentPosition else {return}
//        WeatherService.shared.fetchWeatherData(pos: position) { weatherInfo  in
//            self.weatherInfo = weatherInfo
//            printDebug(weatherInfo.fcs_weathers)
//            self.collectionView.reloadData()
//        }
        
        guard let uuid : String = getData(key: Const.shared.UUID) else {return}
        
        clothings = []
        
        WeatherService.shared.fetchRecommendationCloth(id: uuid, gender: .W, pos: position)
        { info in
            
            DispatchQueue.main.async {
                self.info = info

                let clothingsInfo = info.recommendationClothing
                let mirror = Mirror(reflecting: clothingsInfo)
                for case let (label?, value as ClothingDetails) in mirror.children {
                    if value.image != nil {
                        self.clothings.append(Clothings(key: label, detail: value))
                    }
                }
                
            }
            
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: Selectors
    @objc func handleSettingButtonTapped() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        navigationController?.pushViewController(SettingController(collectionViewLayout: layout), animated: true)
    }
    
    @objc func handleNotificationButtonTapped() {
        
    }
    
    @objc func handleShareButtonTapped() {
        self.metaData = getMetadataForSharingManually(title: "오늘의 기온별 옷차림을 공유해보세요!", url: nil, fileName: nil, fileType: nil)
        shareURLWithMetadata(metadata: metaData)

    }
    
    @objc func handleRefreshButtonTapped() {
        getWeatherData()
    }
    
    
    @objc func handleRefresh() {
        getWeatherData()
    }
    
    @objc func appCameToForeground() {
        locationManager.startUpdatingLocation()
        getWeatherData()
    }

    
    // MARK: Helpers
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainViewHeader.identifier)
        collectionView.register(MainViewProductCell.self, forCellWithReuseIdentifier: MainViewProductCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }

        
    }
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
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
        navigationItem.leftBarButtonItems = [setting]
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
    
   
    func getCurrentPosition() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        

        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("DEBUG: 위치 서비스 on")
                self.locationManager.startUpdatingLocation()
           
            } else {
                print("DEBUG: 위치 서비스 off")
            }
        }
    }
    
    func fetchHtmlParsingResultWill(urlString: String, completion: @escaping(_ href: String)->Void) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        
        guard let url = URL(string: urlString) else {return}
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let willUrl : Elements = try doc.select("a.product_btn_link__XRWYu")
            
            for el in willUrl.array() {
                let href = try el.attr("href")
                if href != "#" {
                    completion(href)
                }
            }
        } catch let error {
            printDebug("Error: \(error)")
        }
        
    }
    
    func shareURLWithMetadata(metadata: LPLinkMetadata) {
        let metadataItemSource = LinkPresentationItemSource(metadata: metadata)
        
        let activityVC = UIActivityViewController(activityItems: [metadataItemSource], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view

        
        
        // 공유하기 기능 중 제외할 기능이 있을때 사용
//        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.present(activityVC, animated: true)
    }

}

extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainViewHeader.identifier, for: indexPath) as! MainViewHeader
        
        if let weatherInfo = info?.weather {
            header.weatherInfo = weatherInfo
        }
        
        header.delegate = self
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewProductCell.identifier, for: indexPath) as! MainViewProductCell
        
        if indexPath.row % 2 == 0 {
            
        }
        
        cell.clothing = clothings[indexPath.row]
        
      
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let urlString = clothings[indexPath.row].detail.link else {return}
        
//        let controller = WebviewController(urlString: urlString)
//        navigationController?.pushViewController(controller, animated: true)
        
        printDebug(urlString)
        
        DispatchQueue.global().async {
            self.fetchHtmlParsingResultWill(urlString: urlString) { href in
                if let url = URL(string: href) {
                    if UIApplication.shared.canOpenURL(url) {
                        DispatchQueue.main.async {
                            self.isAbleToReload = false
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
            }
        }
        
        
    }
}

extension MainViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 515)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row % 2 != 0 {
//            print(indexPath.row)
//            return CGSize(width: (UIScreen.main.bounds.width - 50) / 2, height: 300)
//        }
        return CGSize(width: (view.frame.width - 50) / 2, height: 260)
    }

}


extension MainViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if offsetY >= 50 {
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            self.navigationItem.title = "kiotkiot"
        } else {
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            self.navigationItem.title  = ""
        }
    }
}


extension MainViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        printDebug("⭐️⭐️⭐️ didUpdateLocations : \(locations)")

        if let location = locations.last {
            currentPosition = Position(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            
            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        printDebug(error.localizedDescription)
    }

    
    
}


extension MainViewController : WKNavigationDelegate {
    
}

extension MainViewController : MainViewHeaderDelegate {
    func refetchLocation() {
        printDebug("refetchLocation called")
        locationManager.startUpdatingLocation()
    }
}
