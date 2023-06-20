//
//  SettingController.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/20.
//

import UIKit

class SettingController : UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .weatherGray
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.edgesForExtendedLayout = UIRectEdge.top
        self.navigationController?.navigationBar.tintColor = .weatherGray
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        navigationItem.title = "Settings"
        navigationItem.titleView?.tintColor = .darkText
        
  
    }
    func configureUI() {
        tableView.backgroundColor = .weatherGray
    }
}
