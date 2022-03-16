//
//  Notifications.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 02.03.2022.
//

import Foundation


extension Notification.Name {
    static let eventsTableReadyForReload  =  Notification.Name("eventsTableReadyForReload")
    static let eventTableNewEventInsertion = Notification.Name("eventTableNewEventInsertion")
    static let eventDeleted = Notification.Name("eventDeleted")
}
