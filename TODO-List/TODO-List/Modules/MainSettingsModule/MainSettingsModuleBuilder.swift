//
//  MainSettingsModuleBuilder.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainSettingsModuleBuilder {
    static func build() -> MainSettingsViewController {
        let router = MainSettingsRouter()
        let interactor = MainSettingsInteractor()
        let vc = MainSettingsViewController()
        let presenter = MainSettingsPresenter(view: vc, interactor: interactor, router: router)
        
        interactor.presenter = presenter
        router.view = vc
        vc.presenter = presenter
        
        return vc
    }
}

