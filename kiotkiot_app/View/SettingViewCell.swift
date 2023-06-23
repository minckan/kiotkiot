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
    
    var menu : Menu? {
        didSet {
            configureData()
        }
    }
    
    private let innerContentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let menuImageView : UIImageView = {
        let iv = UIImageView()
        iv.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        return iv
    }()
    
    private let menuLabel : UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 14)
        label.textColor = .black
        
        return label
    }()
    
    var stack = UIStackView()
    
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
    
    // MARK: - Selectors
    @objc func handlePushOnOffButton() {
        
    }
    
    // MARK: - Helpers
    func cofigureUI() {
       
        contentView.addSubview(innerContentView)
        innerContentView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(15)
            make.top.bottom.equalTo(contentView)
        }
        
        stack = UIStackView(arrangedSubviews: [menuImageView, menuLabel])
        innerContentView.addSubview(stack)
        stack.spacing = 10
        stack.axis = .horizontal
        stack.alignment = .center
        
        stack.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(30)
            make.top.bottom.equalTo(contentView)
        }
        
        menuLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
    
    func configureData() {
        guard let menu = menu else {return}
        if let image = menu.icon {
            menuImageView.image = image.withRenderingMode(.alwaysOriginal).withTintColor(.weatherBlue)
            menuLabel.text = menu.title
        } else {
            menuImageView.isHidden = true
            menuLabel.text = "\(menu.title)님 오늘도 행복한 하루 되세요 ✨"
        }
        
        addFunctionToMenu(withMenuType: menu.type)
    }
    
    func addFunctionToMenu(withMenuType type: MenuType) {
        var view = UIView()
        
        switch type {
        case .toggle:
            let switchButton = UISwitch()
            switchButton.onTintColor = .weatherBlue
            switchButton.addTarget(self, action: #selector(handlePushOnOffButton), for: .allTouchEvents)
            view = switchButton
        case .date:
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .time
            
            view = datePicker
        case .transition:
            printDebug("페이지전환")
        case .radio:
            let segmentedControl = UISegmentedControl()
            segmentedControl.insertSegment(withTitle: "남", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "여", at: 1, animated: true)
            segmentedControl.snp.makeConstraints({$0.width.equalTo(100)})
            segmentedControl.selectedSegmentIndex = 0
            
            view = segmentedControl
        case .nonfunctional:
            printDebug("기능없음")
        }
        
        if type != .nonfunctional {
            stack.addArrangedSubview(view)
        }
    }
}
