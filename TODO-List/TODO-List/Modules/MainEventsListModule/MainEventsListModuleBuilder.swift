//
//  MainEventsListModuleBuilder.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainEventsListModulebuilder {
    
    static func build() -> MainEventsListViewController {
        
        let router = MainEventsListRouter()
        let interactor = MainEventsListInteractor()
        let vc = MainEventsListViewController()
        let presenter = MainEventsListPresenter(view: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        router.presenter = presenter
        
        return vc
    }
}
