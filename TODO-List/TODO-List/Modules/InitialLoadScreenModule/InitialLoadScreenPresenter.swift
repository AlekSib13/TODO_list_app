//
//  InitialLoadScreenPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation

class InitialLoadScreenPresenter: InitialLoadScreenPresenterProtocol {
    
    weak var view: InitialLoadScreeenViewControllerProtocol?
    let interactor: InitialLoadScreenInteractorProtocol
    let router: InitialLoadScreenRouterProtocol
    
    init(view: InitialLoadScreeenViewControllerProtocol, interactor: InitialLoadScreenInteractorProtocol, router: InitialLoadScreenRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func enterTheApp(name: String, email: String?) {
        interactor.saveUserCredentials(name: name, email: email)
        router.moveToMainMenu()
    }
    
}
