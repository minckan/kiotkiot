//
//  SettingController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/20.
//

import UIKit

enum MenuType {
    case toggle
    case date
    case transition
    case radio
    case nonfunctional
}

struct Menu {
    var icon: UIImage?
    let title: String
    let type : MenuType
    
    init(iconName: String?, title: String, type: MenuType) {
        if let iconName = iconName {
            self.icon = UIImage(named: iconName)
        }
        
        self.title = title
        self.type = type
    }
}

protocol SettingControllerDelegate : AnyObject {
    func settingHandler()
}

class SettingController : UICollectionViewController {
    // MARK: - Properties
    weak var delegate : SettingControllerDelegate?
    
    private let menuList : [[Menu]] = [
        [Menu(iconName: nil, title: "User_0513", type: .nonfunctional)],
        [Menu(iconName: "user", title: "성별", type: .radio)],
        [Menu(iconName: "notification", title: "푸시알림 on/off", type: .toggle), Menu(iconName: "calander", title: "알림시간 설정", type: .date)]
    ]
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavBar()
       
    }
    
    // MARK: - Selectors
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSaveButton() {
        guard let deviceId = getData(key:Const.shared.UUID) else {return}
        var dict: [String: Any] = ["device_id": deviceId, "push_id": "", "is_using_push": "", "hhmm": ""]
        if let token = getData(key: Const.shared.PUSH_ID) {
            dict["push_id"] = token
        }
        
        if let user_gender = getData(key: Const.shared.TEMP_USER_GENDER) {
            saveData(key: Const.shared.USER_GENDER, value: user_gender)
        }
        
        if let push_status = getData(key: Const.shared.TEMP_PUSH_STATUS) {
            saveData(key: Const.shared.PUSH_STATUS, value: push_status)
            dict["is_using_push"] = push_status
        } else {
            if let push_status = getData(key: Const.shared.PUSH_STATUS) {
                dict["is_using_push"] = push_status
            } else {
                dict["is_using_push"] = "false"
            }
        }
         
        if let push_time = getData(key: Const.shared.TEMP_PUSH_TIME) {
            saveData(key: Const.shared.PUSH_TIME, value: push_time)
            dict["hhmm"] = push_time
        } else {
            if let push_time = getData(key: Const.shared.PUSH_TIME) {
                dict["hhmm"] = push_time
            } else {
                dict["hhmm"] = "08:00"
            }
        }
        

        UserService.shared.registerPushData(dictionary: dict) { [self] in
            printDebug("[handleFCMToken] success!")
            self.navigationController?.popViewController(animated: true)
            self.delegate?.settingHandler()
        }

       

        
    }
    
    // MARK: - Helpers
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .weatherGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        navigationItem.title = "Settings"
        navigationItem.titleView?.tintColor = .darkText
        self.navigationController?.navigationBar.tintColor = .darkText
        
       
        // 시스템 백버튼 스타일 설정
        let backButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleBackButton))
        
        let saveButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(handleSaveButton))
        
        saveButton.tintColor = .weatherBlue

        // 백버튼 이미지에 간격 설정
        let inset: CGFloat = 20.0
        backButton.imageInsets = UIEdgeInsets(top: 0, left: -inset, bottom: 0, right: inset)

        // 백버튼 할당
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = saveButton
    }
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingViewCell.self, forCellWithReuseIdentifier: SettingViewCell.identifier)
        collectionView.register(SettingViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SettingViewHeader.identifier)
        collectionView.backgroundColor = .weatherGray
        
    }
}

extension SettingController  {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList[section].count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingViewCell.identifier, for: indexPath) as! SettingViewCell
        
        cell.menu = menuList[indexPath.section][indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingViewHeader.identifier, for: indexPath) as! SettingViewHeader
        
        if indexPath.section == 1 {
            header.headerText = "맞춤정보 설정"
        } else if indexPath.section == 2 {
            header.headerText = "알림 설정"
        }
        
        return header
    }
    
}

extension SettingController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isFirstSection = indexPath.section == 0
        return CGSize(width: UIScreen.main.bounds.width, height: isFirstSection ? 60 : 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let isFirstSection = section == 0
        return CGSize(width: UIScreen.main.bounds.width, height: isFirstSection ? 20 : 50)
    }
}
