//
//  Errors.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 03.02.2022.
//

import Foundation


enum CalendarError: String, Error {
    case monthMetaDataGeneration = "Calendar Error. Could not create metadata for month"
    case couldNotDefineTheReason = "Calendar Error. Could not define the resason of the error"
}

enum RealmErrors: Int, Error {
    static let description = "Realm Errors"
    
    case couldNotCreateRealm = 0
    case lackOfDiskSpaceOrFileCorruption = 1
    case noPrimaryKeyEntityToMakeLinkToDbObject = 2
    case noObjectInDbForId = 3
    case couldNotDeleteObject = 4
    
    enum RealmErrorsDescription: String {
        case couldNotCreateRealm = "Realm could not create file to save realm data"
        case lackOfDiskSpaceOrFileCorruption = "Please. check available device space and try again. If the issue persists, it is recommended to reinstall the app"
        case noObjectInDbForId = "There is no object in db, which matches the given id"
        case couldNotDeleteObject = "Could not delete object from db"
    }
    
    func describeError() -> String {
        switch self.rawValue {
        case 0:
            return RealmErrorsDescription.couldNotCreateRealm.rawValue
        case 1:
            return RealmErrorsDescription.lackOfDiskSpaceOrFileCorruption.rawValue
        case 2:
            return EventEntityErrors.noPrimaryKeyEntityToMakeLinkToDbObject.rawValue
        case 3:
            return RealmErrorsDescription.noObjectInDbForId.rawValue
        case 4:
            return RealmErrorsDescription.couldNotDeleteObject.rawValue
        default:
            return ""
        }
    }
    
    enum EventEntityErrors: String {
        case noPrimaryKeyEntityToMakeLinkToDbObject = "There is no entity id to make a link to db object: that's is why it can't be used for fetcing an objet from db"
        
    }

}




