//
//  CalendarPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation

class CalendarPresenter: CalendarPresenterProtocol {
    
    weak var view: CalendarViewControllerProtocol?
    let interactor: CalendarInteractorProtocol
    let router: CalendarRouterProtocol
    
    init(view: CalendarViewControllerProtocol?,
         interactor: CalendarInteractorProtocol,
         router: CalendarRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func createMonthMetaData(for baseDate: Date) throws -> MonthMetaData {
        guard let numberOfDaysInMonth = view?.calendar.range(of: .day, in: .month, for: baseDate)?.count, let dateComponents = view?.calendar.dateComponents([.year, .month], from: baseDate), let firstDayOfMonth = view?.calendar.date(from: (dateComponents)),  let firstDayOfWeek = view?.calendar.component(.weekday, from: firstDayOfMonth) else {
            throw CalendarError.monthMetaDataGeneration}
        
        return MonthMetaData(numberOfDays: numberOfDaysInMonth, monthFirstDay: firstDayOfMonth, weekFirstDay: firstDayOfWeek)
    }
    
    
    func dismissCalendar() {
        router.dismissCalendar()
    }
}
