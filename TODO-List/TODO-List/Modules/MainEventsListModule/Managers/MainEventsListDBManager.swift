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
    func deleteEventfromDB(event: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void)
    func readEventsFromDB(completion: @escaping ([NewEvent]?) -> Void)
}

class MainEventsListDBManager: MainEventsListDBManagerProtocol {
    
    func writeEventsToDB(newEvent: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else {return}
            let object = RMNewEvent()
            let realmObject = object.createDbObject(newEvent: newEvent)
            newEvent.id = realmObject.id
            newEvent.eventDateUnix = realmObject.eventDateUnix
             
            do {try self.realmDB.write {
                self.realmDB.add(realmObject, update: .modified)
                }
            DispatchQueue.main.async {
                completion(.success(newEvent))
            }} catch {
                let couldNotWriteError = NSError(domain: RealmErrors.description, code: RealmErrors.lackOfDiskSpaceOrFileCorruption.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.lackOfDiskSpaceOrFileCorruption.describeError()])
                //MARK:TOD: write a pop up, check available space or file is coruppted, app reinstallation required
                DispatchQueue.main.async {
                    completion(.failure(couldNotWriteError))
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
            let realmObjects = self.realmDB.objects(RMNewEvent.self).filter("eventDateUnix >= \(anchorStartDate)").sorted(byKeyPath: "eventDateUnix", ascending: true)
            
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
    
    func deleteEventfromDB(event: NewEvent, completion: @escaping (Result<NewEvent, NSError>) -> Void) {
        guard let id = event.id else {
            let noIdError = NSError(domain: RealmErrors.description, code: RealmErrors.noPrimaryKeyEntityToMakeLinkToDbObject.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.noPrimaryKeyEntityToMakeLinkToDbObject.describeError()])
            completion(.failure(noIdError))
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
            guard let self = self else {return}
            guard let realmObject = self.realmDB.object(ofType: RMNewEvent.self, forPrimaryKey: id) else {
                let noObjectError = NSError(domain: RealmErrors.description, code: RealmErrors.noObjectInDbForId.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.noObjectInDbForId.describeError()])
                DispatchQueue.main.async {
                    completion(.failure(noObjectError))
                }
                return
            }
            do {
                try self.realmDB.write {
                    self.realmDB.delete(realmObject)
                }
                DispatchQueue.main.async {
                    completion(.success(event))
                }
            } catch {
                let couldNotDeleteError = NSError(domain: RealmErrors.description, code: RealmErrors.couldNotDeleteObject.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.couldNotDeleteObject.describeError()])
                DispatchQueue.main.async {
                    completion(.failure(couldNotDeleteError))
                }
            }
        }
    }
}
