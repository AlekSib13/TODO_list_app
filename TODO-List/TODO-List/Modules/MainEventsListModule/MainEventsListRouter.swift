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
    
    
    func openCalendarModule() {
        let vc = CalendarModuleBuilder.build(parentVC: view)
        guard let view = view as? UIViewController else {return}
        view.present(vc, animated: true, completion: nil)
    }
}
