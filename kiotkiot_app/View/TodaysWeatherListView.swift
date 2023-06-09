//
//  WeekWeatherListView.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit
import SwiftUI

class TodaysWeatherListView : UIView {
    // MARK: - Properties
    var weathers : [Weather]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private enum Const {
        static let itemSize = CGSize(width: 60, height: 100)
        static let itemSpacing = 20.0
    }
    private let flowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Const.itemSpacing
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    private var collectionView : UICollectionView
    
    // MARK: Lifecycles
    override init(frame: CGRect) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        super.init(frame: frame)
        setupCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        
        collectionView.backgroundColor = .white
        
        collectionView.register(TodaysWeatherListViewCell.self, forCellWithReuseIdentifier: TodaysWeatherListViewCell.identifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
}

extension TodaysWeatherListView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysWeatherListViewCell.identifier, for: indexPath) as! TodaysWeatherListViewCell
        cell.isNow = indexPath.row == 0
        
        if let weathers = weathers {
            cell.weather = weathers[indexPath.row]
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Const.itemSize
    }
    
}

