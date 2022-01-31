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
    
    
    func dismissCalendar() {
        router.dismissCalendar()
    }
}
