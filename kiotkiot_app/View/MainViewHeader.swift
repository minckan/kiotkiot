//
//  MainViewHeader.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/07.
//

import UIKit

class MainViewHeader : UICollectionReusableView {
    // MARK: - Properties
    static let identifier = "MainViewHeader"
    
    var weatherInfo: WeatherInfo? {
        didSet {
            setData()
        }
    }
    
    private let gpsButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "gps2")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        button.addTarget(self, action: #selector(handleGPSButtonTapped), for: .touchUpInside)
        return button
    }()
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        
        
        
        return label
    }()
    
    private var weatherView : TodaysWeatherView?
    private let todaysWeatherList = TodaysWeatherListView(frame: .zero)
    
    private let todaysWeatherListLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = UIColor.darkText
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 16)
        return label
    }()
    
    private let todaysOutfitsLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Style"
        label.textColor = UIColor.darkText
        label.font = UIFont(name: FontNeo.bold.rawValue, size: 16)
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc func handleGPSButtonTapped() {
        
    }
    
    // MARK: - Helpers
    private func configureUI() {
        let locatioStack = UIStackView(arrangedSubviews: [gpsButton, locationLabel])
        locatioStack.spacing = 5
        locatioStack.axis = .horizontal
        
        addSubview(locatioStack)
        locatioStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.left.equalTo(self)
        }
        
        guard let weatherView = weatherView else {return}
        
        addSubview(weatherView)
        weatherView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(20)
            make.left.right.equalTo(self)
            make.height.equalTo(240) // 280
        }
        
        addSubview(todaysWeatherListLabel)
        todaysWeatherListLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherView.snp.bottom).offset(30)
            make.left.right.equalTo(self)
        }
        
        addSubview(todaysWeatherList)
        todaysWeatherList.snp.makeConstraints { make in
            make.top.equalTo(todaysWeatherListLabel.snp.bottom).offset(4)
            make.left.right.equalTo(self)
            make.height.equalTo(120)
        }
        
        addSubview(todaysOutfitsLabel)
        todaysOutfitsLabel.snp.makeConstraints { make in
            make.top.equalTo(todaysWeatherList.snp.bottom).offset(20)
            make.left.right.equalTo(self)
        }
    }
    
    private func setData() {
        guard let weatherInfo = weatherInfo else {return}
        let viewModel = WeatherInfoViewModel(weatherInfo: weatherInfo)
        
        locationLabel.attributedText = viewModel.locationLabelText
        
        let weather = Weather(weatherImg: UIImage(named: Weathers.sunshine.rawValue)!, temperature: 15, time: "14")
        
        weatherView = TodaysWeatherView(weather: weather)
        
        configureUI()
    }
}
