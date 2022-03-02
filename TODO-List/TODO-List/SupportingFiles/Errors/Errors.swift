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
    
    enum RealmErrorsDescription: String {
        case couldNotCreateRealm = "Realm could not create file to save realm data"
        case lackOfDiskSpaceOrFileCorruption = "Please. check available device space and try again. If the issue persists, it is recommended to reinstall the app"
    }
    
    func describeError() -> String {
        switch self.rawValue {
        case 0:
            return RealmErrorsDescription.couldNotCreateRealm.rawValue
        case 1:
            return RealmErrorsDescription.lackOfDiskSpaceOrFileCorruption.rawValue
        default:
            return ""
        }
    }
}



