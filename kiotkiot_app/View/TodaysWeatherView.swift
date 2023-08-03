//
//  TodaysWeatherView.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit

class TodaysWeatherView : UIView {
    // MARK: - Properties
    var weather : Weather? {
        didSet {
            configure()
        }
    }
    
    var weatherStatus : Weathers? {
        didSet {
           configureBackground()
        }
    }
    
    private let weatherImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
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
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 62)
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)

        
    }
    
    convenience init(weather: Weather) {
        self.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width - 40, height: 280)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    
    private func configure() {
        guard let weather = weather else {return}
        dateLabel.text = weather.date?.toDate()?.toString()
        weatherLabel.text = weather.weatherText
        weatherImage.image = weather.weatherImg
        temperatureLabel.text = weather.temperature
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            // 1초 후에 실행될 코드를 여기에 작성합니다.
//            print("1초 후에 실행되었습니다.")
//            saveViewAsImage(view: self)
//        }
        
    
    }
    
    
    private func configureBackground() {
        if let status = weatherStatus {
            bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width - 40, height: 280))
            backgroundColor = status.background.color2
            self.setGradient(status.background)
            
            layer.cornerRadius = 8
            layer.masksToBounds = true
            
            addSubview(weatherImage)
            weatherImage.snp.makeConstraints { make in
                make.top.equalTo(self).offset(25)
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
                make.bottom.equalTo(self).offset(-25)
                make.left.right.equalTo(self)
            }
       
        }
       
    }
    
    func getViewAsImage() -> UIImage? {
       return self.transfromToImage()
    }
    
}
