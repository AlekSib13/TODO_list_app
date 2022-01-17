//
//  InitialLoadScreenModuleBuilder.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation

class InitialLoadScreenModuleBuilder {
    
    static func build() -> InitialLoadScreeenViewController {
        let vc = InitialLoadScreeenViewController()
        let interactor = InitialLoadScreenInteractor()
        let router = InitialLoadScreenRouter()
        let presenter = InitialLoadScreenPresenter(view: vc, interactor: interactor, router: router)
        
        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = vc
        
        return vc
    }
}
