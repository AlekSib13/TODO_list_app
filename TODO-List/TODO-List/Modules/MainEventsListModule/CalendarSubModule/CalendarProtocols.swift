//
//  CalendarProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation
import UIKit

protocol CalendarViewControllerProtocol: class {
    var calendar: Calendar {get}
    var calendarCollectionView: UICollectionView {get}
    func updateCalendarHeader(date: Date)
    func hidePreviousMonthButton(hide: Bool)
}

protocol CalendarPresenterProtocol: class,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CalendarDelegate {
    func viewDidLoad()
}

protocol CalendarInteractorProtocol: class {
    
}

protocol CalendarRouterProtocol: class {
    func dismissCalendar()
}

protocol CalendarDateCellDelegate: class {
    
}

protocol CalendarDelegate: class {
    func closeCalendar()
    func openNextMonth()
    func openPreviousMonth()
    func saveDate()
}

protocol CalendarExternalDelegate: class {
    func saveCalendarDate(chosenDate: String)
}

