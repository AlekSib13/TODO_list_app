//
//  MainMenuModuleBuilder.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 05.12.2021.
//

import Foundation


class MainMenuTabBarModuleBuilder {
    static func build() ->  MainMenuTabBarViewController {
        let router = MainMenuTabBarRouter()
        let interactor = MainMenuTabBarInteractor()
        let vc = MainMenuTabBarViewController()
        let presenter = MainMenuTabBarPresenter(view: vc, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        vc.presenter = presenter
        router.view = vc
        
        return vc
    }
}
