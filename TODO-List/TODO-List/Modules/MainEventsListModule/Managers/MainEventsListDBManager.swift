//
//  MainEventsListDBManager.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 27.02.2022.
//

import Foundation
import RealmSwift

protocol MainEventsListDBManagerProtocol: BaseRealm {
    func writeEventsToDB(newEvent: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void)
    
}

class MainEventsListDBManager: MainEventsListDBManagerProtocol {
    func writeEventsToDB(newEvent: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void) {
        let object = RMNewEvent()
        let realmObject = object.createDbObject(newEvent: newEvent, id: 0)
        print("realmObject date and time \(realmObject.eventDateAndTime), realmObject date: \(realmObject.date) ")
        
    }
    
    

}
