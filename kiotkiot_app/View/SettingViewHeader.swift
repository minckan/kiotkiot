//
//  SettingViewHeader.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/23.
//

import UIKit

class SettingViewHeader : UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "SettingViewHeader"
    var headerText : String? {
        didSet {
            setText()
        }
    }
    
    private let label = UILabel()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)

       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    private func setText() {
        if let headerText = headerText {
            addSubview(label)
            label.text = headerText
            label.textColor = .gray
            label.font = UIFont(name: FontNeo.bold.rawValue, size: 13)
            label.snp.makeConstraints { make in
                make.left.equalTo(self).inset(25)
                make.bottom.equalTo(self).inset(12)
            }
        }
    }
}
