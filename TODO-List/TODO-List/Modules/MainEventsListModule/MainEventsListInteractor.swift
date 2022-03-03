//
//  MainEventsListInteractor.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation

class MainEventsListInteractor:  MainEventsListInteractorProtocol {
    
    var firstLoad = true
    var items = [NewEvent]() {
        didSet {
            if firstLoad, items.count != 0 {
                calculateItemsSections()
                NotificationCenter.default.post(name: Notification.Name.eventsTableReadyForReload, object: nil)
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
    
    var newEvent = NewEvent(eventTime: nil, eventDate: nil, eventText: nil, eventImportance: nil, id: nil)
    
    func saveTimeAndText(eventInfo: (String, String), completion: () -> ()) {
        newEvent.eventTime = eventInfo.0
        newEvent.eventText = eventInfo.1
        completion()
    }
    
    func saveCalendarDate(chosenDate: String) {
        newEvent.eventDate = chosenDate
    }
    
    func saveNewEvent() {
        manager.saveData(newEvent: newEvent) {result in
            print("event saved")
        }
    }
    
    func getEvents() {
        manager.getData() {[weak self] result in
            guard let self = self else {return}
            !result.isEmpty ? self.items = result : self.presenter?.showPlaceHolderNoData()
        }
    }
    
//    func calculateItemsSections() {
//        let dateFromatter = TimeConverterHelper()
//        let values = Set(items.compactMap{$0.id}).lazy.map{$0}.sorted(by: {$1>$0})
//        let dates = values.map{Date(timeIntervalSince1970: TimeInterval($0))}
//        self.itemSections = dates.map{(date: Date) -> String in
//            let array = date.description.split(separator: " ")
//            return String(array.first ?? "")
//        }
//    }
    
    
    func calculateItemsSections() {
        let dateFormatter = TimeConverterHelper()
        //MARK: TODO: when sort feature will be implemented do not forget to change sorting condition below
        //MARK: TODO: work with date should be reconsidered, there are excess operations, which transform date to string and back
        let dates = Set(items.compactMap{dateFormatter.getFullDateFromDate(day: ($0.eventDate ?? "") + "T" + "11:59 PM")}).lazy.sorted(by: {$0<$1})
        self.itemSections = dates.map{(date: Date) -> String in
            let array = date.description.split(separator: " ")
            return String(array.first ?? "")
        }
        
        print("itemssections: \(itemSections)")
    }
}
