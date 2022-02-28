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
    
    enum RealmErrorsDescription: String {
        case couldNotCreateRealm = "Realm could not create file to save realm data"
    }
    
    func describeError() -> String {
        switch self.rawValue {
        case 0 :
            return RealmErrorsDescription.couldNotCreateRealm.rawValue
        default:
            return ""
        }
    }
}



