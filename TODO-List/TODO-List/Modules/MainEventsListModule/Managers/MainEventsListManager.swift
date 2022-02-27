//
//  MainEventsListManager.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 27.02.2022.
//

import Foundation
import PromiseKit

protocol MainEventsListManagerProtocol {}

class MainEventsListManager: MainEventsListManagerProtocol {
    
    let dbManager: MainEventsListDBManagerProtocol
    
    init(dbManager: MainEventsListDBManagerProtocol = MainEventsListDBManager()) {
        self.dbManager = dbManager
    }
    
}
