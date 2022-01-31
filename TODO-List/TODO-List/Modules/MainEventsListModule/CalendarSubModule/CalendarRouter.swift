//
//  CalendarRouter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation
import UIKit

class CalendarRouter: CalendarRouterProtocol {
    
    weak var view: MainEventsListViewControllerProtocol?
    
    
    func dismissCalendar() {
        guard let view = view as? UIViewController else {return}
        view.dismiss(animated: true, completion: nil)
    }
}
