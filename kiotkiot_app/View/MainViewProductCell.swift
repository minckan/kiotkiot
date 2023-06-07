//
//  MainViewCell.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

class MainViewProductCell : UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "MainViewProductCell"
    
    private let productImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pants")
        iv.layer.cornerRadius = 15
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let tagLabel : UILabel = {
        let label = UILabel()
        label.text = "#바지"
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 16)
        label.textColor = .darkGray
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .weatherGray
        
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(220)
        }
        
        addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.left.equalTo(contentView)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
}

