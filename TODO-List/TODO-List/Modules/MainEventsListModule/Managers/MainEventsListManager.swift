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
    func getData(completion: @escaping ([NewEvent]) -> Void)
    func deleteData(event: NewEvent, completion: @escaping (NewEvent) -> Void)
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
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func getData(completion: @escaping ([NewEvent]) -> Void) {
        dbManager.readEventsFromDB{result in
            completion(result ?? [NewEvent]())
        }
    }
    
    func deleteData(event: NewEvent, completion: @escaping (NewEvent) -> Void) {
        //MARK: TODO: debug script to see if extra background threads are used
        dbManager.deleteEventfromDB(event: event) {result in
            switch result {
            case .success(let eventDeleted):
            print("Event deleted: \(eventDeleted)")
                completion(eventDeleted)
            case .failure(let error):
                //MARK: TODO develop this part of code
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
