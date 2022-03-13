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
    func readEventsFromDB(completion: @escaping ([NewEvent]?) -> Void)
}

class MainEventsListDBManager: MainEventsListDBManagerProtocol {
    
    func writeEventsToDB(newEvent: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else {return}
            let object = RMNewEvent()
            let realmObject = object.createDbObject(newEvent: newEvent)
            newEvent.id = realmObject.id
            do {try self.realmDB.write {
                self.realmDB.add(realmObject, update: .modified)
                DispatchQueue.main.async {
                    completion(.success(newEvent))
                }
            }} catch {
                let realmError = NSError(domain: RealmErrors.description, code: RealmErrors.lackOfDiskSpaceOrFileCorruption.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.lackOfDiskSpaceOrFileCorruption.describeError()])
                print(realmError.localizedDescription)
                //MARK:TOD: write a pop up, check available space or file is coruppted, app reinstallation required
                DispatchQueue.main.async {
                    completion(.failure(realmError))
                }
            }
        }
    }
    
    
    func readEventsFromDB(completion: @escaping ([NewEvent]?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else {return}
            let dateFormatter = TimeConverterHelper()
            //MARK: currently only events with due later today and later are considered, allow the user to search for passed events as well + implement searchfield
            let anchorStartDate = Int(Date().timeIntervalSince1970)
            let realmObjects = self.realmDB.objects(RMNewEvent.self).filter("id >= \(anchorStartDate)").sorted(byKeyPath: "id", ascending: true)
            if realmObjects.count == 0 {
                DispatchQueue.main.async {
                    completion(nil)
                }
            } else {
                var eventsList = [NewEvent]()
                for event in realmObjects {
                    eventsList.append(event.createModelObject())
                }
                DispatchQueue.main.async {
                    completion(eventsList)
                }
            }
        }
    }
}
