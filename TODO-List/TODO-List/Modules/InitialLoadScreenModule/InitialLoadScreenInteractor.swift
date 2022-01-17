//
//  InitialLoadScreenInteractor.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation
import RealmSwift
import PromiseKit


class InitialLoadScreenInteractor: InitialLoadScreenInteractorProtocol {
    weak var presenter: InitialLoadScreenPresenterProtocol?

    func saveUserCredentials(name: String, email: String?) {
        //saveToDB
    }
}
