//
//  InitialLoadScreenRouter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation
import UIKit

class InitialLoadScreenRouter: InitialLoadScreenRouterProtocol {
    weak var view: InitialLoadScreeenViewControllerProtocol?
    
    var nvc: UINavigationController? {
        guard let vc = view as? UIViewController else {return nil}
        return vc.navigationController
    }
    
    
    func moveToMainMenu() {
        guard let nvc = nvc else {return}
        let vc = MainMenuTabBarModuleBuilder.build()
        nvc.pushViewController(vc, animated: true)
    }
}
