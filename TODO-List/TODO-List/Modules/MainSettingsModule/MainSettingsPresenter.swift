//
//  MainSettingsPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainSettingsPresenter: MainSettingsPresenterProtocol {
    
    weak var view: MainSettingsViewControllerProtocol?
    let interactor: MainSettingsInteractorProtocol
    let router: MainSettingsRouterProtocol
    
    init(view: MainSettingsViewControllerProtocol, interactor:  MainSettingsInteractorProtocol, router: MainSettingsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
