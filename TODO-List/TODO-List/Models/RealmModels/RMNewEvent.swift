//
//  RMNewEvent.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.02.2022.
//

import Foundation
import RealmSwift

class RMNewEvent: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var eventText: String? = nil
    @objc dynamic var eventImportance = 0
    @objc dynamic var eventDate = Date()
    @objc dynamic var eventDateUnix = 0
    
    override static func primaryKey() -> String? {
        "id"
    }
    
    
    func createDbObject(newEvent: NewEvent) -> RMNewEvent {
        let dateFormater = TimeConverterHelper()
        
        let eventDate = dateFormater.getFullDateFromDate(day: ((newEvent.eventDate ?? "") + "T" + (newEvent.eventTime ?? ""))) ?? Date()
        
        self.id = Int(Date().timeIntervalSince1970)
        self.eventText = newEvent.eventText
        self.eventImportance = newEvent.eventImportance ?? 0
        self.eventDate = eventDate
        self.eventDateUnix = Int(eventDate.timeIntervalSince1970)
        return self
    }
    
    
    func createModelObject() -> NewEvent {
        let dateFormatter = TimeConverterHelper()
        let localTime = dateFormatter.convertTimeDateToLocal(date: self.eventDate)
        let dateTimeArray = localTime.split(separator: "T")
        
        return NewEvent(eventTime: String(dateTimeArray[1]), eventDate: String(dateTimeArray.first ?? ""), eventText: self.eventText, eventImportance: self.eventImportance, id: self.id, eventDateUnix: self.eventDateUnix)
    }
}
