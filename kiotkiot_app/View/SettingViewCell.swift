//
//  SettingViewCell.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/21.
//

import UIKit

class SettingViewCell : UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "SettingViewCell"
    
    private let innerContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        return view
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cofigureUI()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func cofigureUI() {
       
        contentView.addSubview(innerContentView)
        innerContentView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(15)
            make.top.bottom.equalTo(contentView)
        }
        
    }
}
