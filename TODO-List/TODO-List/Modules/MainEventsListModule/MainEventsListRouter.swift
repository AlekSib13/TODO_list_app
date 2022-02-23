//
//  MainEventsListRouter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

class MainEventsListRouter:  MainEventsListRouterProtocol {
    
    weak var view: MainEventsListViewControllerProtocol?
    weak var presenter: MainEventsListPresenterProtocol?
    
    
    func openCalendarModule() {
        let vc = CalendarModuleBuilder.build(parentVC: view, delegate: presenter)
        guard let view = view as? UIViewController else {return}
        view.present(vc, animated: true, completion: nil)
    }
}
