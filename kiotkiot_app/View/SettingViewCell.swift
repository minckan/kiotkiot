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
    @objc func handlePushOnOffButton(sender: UISwitch) {
        saveData(key: Const.shared.TEMP_PUSH_STATUS, value: "\(sender.isOn)")
    }
    
    @objc func handleGenderChange(segcon: UISegmentedControl) {
        printWithLabel(label: "handleGenderChange", message: segcon.selectedSegmentIndex)
        let genderString = segcon.selectedSegmentIndex == 0 ? Gender.M : Gender.W
        saveData(key: Const.shared.TEMP_USER_GENDER, value: genderString.rawValue)
    }
    
    @objc func handleTimeChanged(datepic: UIDatePicker) {
        let formmatedValue = getDataFormmatter().string(from:datepic.date)
        
        saveData(key: Const.shared.TEMP_PUSH_TIME, value:formmatedValue)
    }
    
    // MARK: - Helpers
    func getDataFormmatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "HH:mm"
     
      
        return dateFormatter
    }
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
            switchButton.setOn(Bool(getData(key: Const.shared.PUSH_STATUS) ?? "false") ?? false, animated: true)
           
            switchButton.onTintColor = .weatherBlue
            switchButton.addTarget(self, action: #selector(handlePushOnOffButton), for: .allTouchEvents)
            view = switchButton
        case .date:
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .time
            
            let dateFormmatter = getDataFormmatter()
            if let timeValue = getData(key: Const.shared.PUSH_TIME) {
                guard let date = dateFormmatter.date(from: timeValue) else { return  }
                datePicker.setDate(date, animated: true)
            } else {
                guard let date = dateFormmatter.date(from: "08:00") else { return  }
                datePicker.setDate(date, animated: true)
            }
            datePicker.addTarget(self, action: #selector(handleTimeChanged), for: .valueChanged)
            
            view = datePicker
        case .transition:
            printDebug("페이지전환")
        case .radio:
            let segmentedControl = UISegmentedControl()
            segmentedControl.insertSegment(withTitle: "남", at: 0, animated: true)
            segmentedControl.insertSegment(withTitle: "여", at: 1, animated: true)
            segmentedControl.snp.makeConstraints({$0.width.equalTo(100)})
            segmentedControl.selectedSegmentTintColor = UIColor.weatherBlue
        
            let savedGender = getData(key: Const.shared.USER_GENDER) ?? Gender.W.rawValue
            
            segmentedControl.selectedSegmentIndex = savedGender == Gender.M.rawValue ? 0 : 1
            segmentedControl.addTarget(self, action: #selector(handleGenderChange), for: .valueChanged)
            
            view = segmentedControl
        case .nonfunctional:
            printDebug("기능없음")
        }
        
        if type != .nonfunctional {
            stack.addArrangedSubview(view)
        }
    }
}
