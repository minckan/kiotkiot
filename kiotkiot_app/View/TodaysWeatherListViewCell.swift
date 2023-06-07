//
//  TodaysWeatherListViewCell.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

class TodaysWeatherListViewCell : UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "TodaysWeatherListViewCell"
    var isNow : Bool? {
        didSet {
            configureUI()
        }
    }
    
    var weather : Weather? {
        didSet {
            setWeatherData()
        }
    }
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNeo.medium.rawValue, size: 12)
        return label
    }()
    
    private let weatherImageView : UIImageView = {
        let iv = UIImageView()
        iv.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let temperatreLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNeo.black.rawValue, size: 16)
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    private func configureUI() {
        layer.cornerRadius = 10
        
        let stack = UIStackView(arrangedSubviews: [timeLabel, weatherImageView, temperatreLabel])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(10)
        }
        
        guard let isNow = isNow else {return}
        
        if isNow {
            backgroundColor = .weatherBlue
            layer.shadowColor = UIColor.weatherBlue.cgColor
            layer.shadowPath = nil
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 5
            timeLabel.textColor = .white
            temperatreLabel.textColor = .white
        } else {
            backgroundColor = .white
            layer.borderWidth = 0.3
            layer.borderColor = UIColor.lightGray.cgColor
            timeLabel.textColor = UIColor.darkText
            temperatreLabel.textColor = UIColor.darkText
        }
        
        
    }
    
    private func setWeatherData() {
        guard let weather = weather else {return}
        guard let isNow = isNow else {return}
        
        timeLabel.text = weather.time
        weatherImageView.image = weather.weatherImg
        temperatreLabel.text = "\(String(weather.temperature))º"
        
        if isNow {
            temperatreLabel.text = "Now"
        }
    }
    
}
