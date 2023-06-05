//
//  TodaysWeatherView.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit

class TodaysWeatherView : UIView {
    // MARK: - Properties
    private let weatherImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sunshine")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "아주 맑음"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: FontNeo.black.rawValue, size: 22)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday, 02 June"
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.font = UIFont(name: FontNeo.regular.rawValue, size: 14)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "26º"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 62)
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .weatherBlue
        layer.cornerRadius = 20
        
        addSubview(weatherImage)
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(self).offset(30)
            make.left.right.equalTo(self)
        }
        
        addSubview(weatherLabel)
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp.bottom).offset(15)
            make.left.right.equalTo(self)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(5)
            make.left.right.equalTo(self)
        }
        
        addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-30)
            make.left.right.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
}
