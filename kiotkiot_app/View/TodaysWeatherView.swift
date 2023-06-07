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
        iv.image = UIImage(named: "cloudy")
        iv.contentMode = .scaleAspectFit
//        iv.snp.makeConstraints { make in
//            make.width.equalTo(80)
//        }
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
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.text = "26º"
        label.textAlignment = .center
//        label.textColor = .white
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 62)
        let gradient = getGradientLayer(bounds: label.bounds, colors: [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0.5).cgColor])
        label.textColor = gradientColor(bounds: label.bounds, gradientLayer: gradient)
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .weatherBlue
        bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width - 40, height: 280))
        setGradient(color1: .weatherBlue.withAlphaComponent(0.7), color2: .weatherBlue)
        
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
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
        
        
//        let stackVertical = UIStackView(arrangedSubviews: [weatherImage, weatherLabel, dateLabel])
//        stackVertical.axis = .vertical
//
//
//        weatherImage.snp.makeConstraints { make in
//            make.width.equalTo(stackVertical)
//        }
//
//        let stackHorizontal = UIStackView(arrangedSubviews: [stackVertical, temperatureLabel])
//        stackHorizontal.axis = .horizontal
//        stackHorizontal.distribution = .equalCentering
//        stackHorizontal.alignment = .fill
//
//
//
//        addSubview(stackHorizontal)
//        stackHorizontal.snp.makeConstraints { make in
//            make.top.bottom.equalTo(self).inset(20)
//            make.left.right.equalTo(self).inset(30)
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
}
