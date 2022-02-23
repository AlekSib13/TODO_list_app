//
//  CalendarModuleBuilder.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation

class CalendarModuleBuilder {
    static func build(parentVC: MainEventsListViewControllerProtocol?, delegate: CalendarExternalDelegate?) -> CalendarViewController {
        
        let router = CalendarRouter()
        let interactor = CalendarInteractor()
        let vc = CalendarViewController()
        let presenter = CalendarPresenter(view: vc, interactor: interactor, router: router, baseDate: Date())
        
        let timeConverter = TimeConverterHelper()
        print("date time \(Date()), local datetime \(timeConverter.getCurrentDate(date: Date()))****")
        
        vc.presenter = presenter
        interactor.presenter = presenter
        router.view = parentVC
        
        presenter.delegate = delegate
        
        return vc
    }
}
