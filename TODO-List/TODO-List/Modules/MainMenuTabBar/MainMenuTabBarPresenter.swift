//
//  MainMenuPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 05.12.2021.
//

import Foundation
import UIKit

class MainMenuTabBarPresenter: NSObject, MainMenuTabBaPresenterProtocol, UITabBarControllerDelegate {
    weak var view: MainMenuTabBarViewControllerProtocol?
    let interactor: MainMenuTabBaInteractorProtocol
    let router: MainMenuTabBaRouterProtocol
    
    init(view: MainMenuTabBarViewControllerProtocol, interactor: MainMenuTabBaInteractorProtocol,
         router: MainMenuTabBaRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
}
