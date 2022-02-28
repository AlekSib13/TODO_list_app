//
//  MainEventsListManager.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 27.02.2022.
//

import Foundation
import PromiseKit

protocol MainEventsListManagerProtocol {
    func saveData(newEvent: NewEvent, completion: @escaping (NewEvent) -> Void)
    //MARK: TODO: check async code, somewhere @escpaing is not required
}



class MainEventsListManager: MainEventsListManagerProtocol {
    
    let dbManager: MainEventsListDBManagerProtocol
    
    init(dbManager: MainEventsListDBManagerProtocol = MainEventsListDBManager()) {
        self.dbManager = dbManager
    }
    
    
    func saveData(newEvent: NewEvent, completion: @escaping (NewEvent) -> Void) {
        dbManager.writeEventsToDB(newEvent: newEvent) {result in
            switch result {
            case .success(let savedEvent):
            print("savedEvent: \(savedEvent)")
                completion(newEvent)
            case .failure(let error):
                //MARK: TODO develop this part of code
                print("error")
            }
        }
    }
}
