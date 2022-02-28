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
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        "id"
    }
    
    
    func createDbObject(newEvent: NewEvent, id: Int) -> RMNewEvent {
        let dateFormater = TimeConverterHelper()
        
        self.id = id
        self.eventText = newEvent.eventText
        self.eventImportance = newEvent.eventImportance ?? 0
        self.date = dateFormater.getFullDateFromDate(day: ((newEvent.eventDate ?? "") + "T" + (newEvent.eventTime ?? ""))) ?? Date()
        return self
    }
    
    func createModelObject(dBEvent: RMNewEvent) -> NewEvent {
        let dateFormatter = TimeConverterHelper()
        let localTime = dateFormatter.convertTimeToLocal(date: dBEvent.date)
        let dateTimeArray = localTime.split(separator: " ")
        
        return NewEvent(eventTime: String(dateTimeArray[1]), eventDate: String(dateTimeArray.first ?? ""), eventText: dBEvent.eventText, eventImportance: dBEvent.eventImportance)
    }
}
