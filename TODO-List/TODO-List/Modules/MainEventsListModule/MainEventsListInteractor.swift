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
    
    func saveTimeAndText(eventInfo: (String, String)) {
        newEvent.eventTime = eventInfo.0
        newEvent.eventTime = eventInfo.1
    }
}
