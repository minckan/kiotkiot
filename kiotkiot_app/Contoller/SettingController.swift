//
//  SettingController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/20.
//

import UIKit

class SettingController : UICollectionViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycles
//    init() {
//        let layout = UICollectionViewLayout()
//        super.init(collectionViewLayout: layout)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
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
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else {
            return 2
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingViewCell.identifier, for: indexPath) as! SettingViewCell

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingViewHeader.identifier, for: indexPath) as! SettingViewHeader
        
        printDebug(indexPath.section)
        
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
