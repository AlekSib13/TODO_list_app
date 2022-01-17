//
//  InitialLoadScreenProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation

protocol InitialLoadScreeenViewControllerProtocol: class {
}

protocol InitialLoadScreenPresenterProtocol: class {
    func enterTheApp(name: String, email: String?)
}

protocol InitialLoadScreenInteractorProtocol: class {
    func saveUserCredentials(name: String, email: String?)
}

protocol InitialLoadScreenRouterProtocol: class {
    func moveToMainMenu()
}
