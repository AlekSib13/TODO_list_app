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
