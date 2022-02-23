//
//  MainEventsListInteractor.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainEventsListInteractor:  MainEventsListInteractorProtocol {

    weak var presenter: MainEventsListPresenterProtocol?
    
    var newEvent = NewEvent(eventTime: nil, eventDate: nil, eventText: nil, eventImportance: nil)
    
    func saveTimeAndText(eventInfo: (String, String), completion: () -> ()) {
        newEvent.eventTime = eventInfo.0
        newEvent.eventText = eventInfo.1
        completion()
    }
    
    func saveCalendarDate(chosenDate: String) {
        newEvent.eventDate = chosenDate
    }
    
    func saveNewEvent() {
        print("this is event, which is going to be saved: \(newEvent.eventDate), \(newEvent.eventTime), \(newEvent.eventText)")
    }
}
