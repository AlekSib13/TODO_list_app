//
//  MainEventsListProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit
import AsyncDisplayKit

protocol MainEventsListViewControllerProtocol: class {
    func showCalendarDate(chosenDate: String)
}

protocol MainEventsListPresenterProtocol: class, UIPageViewControllerDataSource, UIPageViewControllerDelegate, ASTableDataSource, ASTableDelegate, NewEventHandlerDelegateProtocol, NewEventCalendardDelegateProtocol, CalendarExternalDelegate {}

protocol MainEventsListInteractorProtocol: class {
    func saveTimeAndText(eventInfo: (String, String), completion: () -> ())
    func saveCalendarDate(chosenDate: String)
    func saveNewEvent()
}

protocol MainEventsListRouterProtocol: class {
    func openCalendarModule()
}


protocol MainEventsListCurrentListViewControllerProtocol {
    var tableNode: ASTableNode {get}
}

protocol MainEventsListPageViewControllerProtocol {}

protocol NewEventHandlerDelegateProtocol {
    func saveTime(date: Date) // delete method
    func openCalendar()
    func saveTimeAndText(eventInfo: (String, String))
}

protocol NewEventCalendardDelegateProtocol {
    
}
