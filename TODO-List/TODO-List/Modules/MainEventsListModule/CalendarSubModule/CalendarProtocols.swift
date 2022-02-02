//
//  CalendarProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation


protocol CalendarViewControllerProtocol: class {
    var calendar: Calendar {get}
}

protocol CalendarPresenterProtocol: class {
    func dismissCalendar()
}

protocol CalendarInteractorProtocol: class {
    
}

protocol CalendarRouterProtocol: class {
    func dismissCalendar()
}

