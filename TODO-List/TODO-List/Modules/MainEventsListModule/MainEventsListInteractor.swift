//
//  MainEventsListInteractor.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainEventsListInteractor:  MainEventsListInteractorProtocol {

    var initialLoad = true
    
    var items = [NewEvent]() {
        didSet {
            if !items.isEmpty {
                calculateItemsSections()
            }
        }
    }
    
    var itemSections = [String]()
    
    weak var presenter: MainEventsListPresenterProtocol?
    let manager: MainEventsListManagerProtocol
    
    init(manager: MainEventsListManagerProtocol = MainEventsListManager()) {
        self.manager = manager
        getEvents()
    }
    
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
        manager.saveData(newEvent: newEvent) {[weak self] result in
            guard let self = self else {return}
            
            let eventForInsertion = NewEvent(eventTime: result.eventTime, eventDate: result.eventDate, eventText: result.eventText, eventImportance: result.eventImportance, id: result.id, eventDateUnix: result.eventDateUnix)
            
            guard let dateOfInsertedEvent = eventForInsertion.eventDateUnix else {return}
            
            let dates = self.items.compactMap{$0.eventDateUnix}
            var itemIndex = 0
            
            for date in dates {
                if dateOfInsertedEvent <= date {
                    break
                }
                itemIndex += 1
            }
            
            self.items.insert(eventForInsertion, at: itemIndex)
            
            guard let index = self.findNewEventIndexInSection(newEvent: eventForInsertion) else {return}
            
            self.presenter?.insertNewEvent(atIndex: index)
        }
    }
    
    func getEvents() {
        manager.getData() {[weak self] result in
            guard let self = self else {return}
            
            if !result.isEmpty {
                self.items = result
                self.updateData()
            } else {
                self.presenter?.showPlaceHolderNoData()
            }
        }
    }
    
    
    func calculateItemsSections() {
        let dateFormatter = TimeConverterHelper()
        //MARK: TODO: when sort feature will be implemented do not forget to change sorting condition below
        //MARK: TODO: work with date should be reconsidered, there are excess operations, which transform date to string and back
        let dates = Set(items.compactMap{dateFormatter.getFullDateFromDate(day: ($0.eventDate ?? "") + "T" + "11:59 PM")}).sorted(by: {$0<$1})
        print("all dates: \(dates)")
        
        self.itemSections = dates.map{(date: Date) -> String in
            let array = date.description.split(separator: " ")
            return String(array.first ?? "")
        }
    }
    
    
    private func findNewEventIndexInSection(newEvent: NewEvent) -> (section: Int, row: Int)? {
        guard let newEventDay = newEvent.eventDate,
              let newEventSectionIndex = self.itemSections.firstIndex(of: newEventDay), let newEventId = newEvent.id else {return nil}
    
        let arrayOfEventsIds = self.items.filter{$0.eventDate == newEventDay}.compactMap{$0.id}
        
        var rowIndex = 0
        for id in arrayOfEventsIds {
            if newEventId <= id {
                break
            }
            rowIndex += 1
        }
        return (section: newEventSectionIndex, row: rowIndex)
    }
    
    
    func updateData() {
        NotificationCenter.default.post(name: Notification.Name.eventsTableReadyForReload, object: nil)
    }
    
//    func insertNewEvent(atIndex: (Int,Int)) {
//        let dataToPass = (atIndex: atIndex, numberOfSections: self.itemSections.count)
//        
//        NotificationCenter.default.post(name: Notification.Name.eventTableNewEventInsertion, object: dataToPass)
//    }
    
    func deleteEvent(event: NewEvent) {
        manager.deleteData(event: event) {[weak self] event in
            guard let self = self, let deletedEventId = event.id else {return}
            self.items.removeAll(where: {($0.id ?? 0) == deletedEventId})
            self.presenter?.eventDeleted()
        }
    }
   
}
