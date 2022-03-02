//
//  File.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 22.02.2022.
//

import Foundation

//MARK: TODO: change NewEvent name to Event

class NewEvent {
    
    var eventText: String?
    var eventTime: String?
    var eventDate: String?
    var eventImportance: Int?
    
    
    init(eventTime: String?, eventDate: String?, eventText: String?, eventImportance: Int?) {
        self.eventTime = eventTime
        self.eventDate = eventDate
        self.eventText = eventText
        self.eventImportance = eventImportance
    }
}
