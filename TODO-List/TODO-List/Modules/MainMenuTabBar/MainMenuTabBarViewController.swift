//
//  MainMenuController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 05.12.2021.
//

import UIKit

class MainMenuTabBarViewController: UITabBarController, MainMenuTabBarViewControllerProtocol {

    var presenter: MainMenuTabBarPresenter?
    
    let mainEventsListNavigationController = DarkNavigationController(rootViewController: MainEventsListModulebuilder.build())
    let mainSettingsNavigationController = DarkNavigationController(rootViewController: MainSettingsModuleBuilder.build())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure() {
        delegate = presenter
        view.backgroundColor = .white
        
        configureTabBarItems()
    }
    
    func configureTabBarItems() {
        mainEventsListNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage.MainTabBar.eventsList, tag: 0)
        mainEventsListNavigationController.tabBarItem.imageInsets = Constants.tabBarImageInsets.tabImageInset
        
        mainSettingsNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage.MainTabBar.settings, tag: 1)
        mainSettingsNavigationController.tabBarItem.imageInsets = Constants.tabBarImageInsets.tabImageInset
        
        viewControllers = [mainEventsListNavigationController, mainSettingsNavigationController]
    }
}

