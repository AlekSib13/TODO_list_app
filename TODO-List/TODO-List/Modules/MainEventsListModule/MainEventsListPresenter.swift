//
//  MainEventsListPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

class MainEventsListPresenter: NSObject, MainEventsListPresenterProtocol {
 
    weak var view: MainEventsListViewControllerProtocol?
    let interactor: MainEventsListInteractorProtocol
    let router: MainEventsListRouterProtocol
    
    init(view: MainEventsListViewControllerProtocol, interactor: MainEventsListInteractorProtocol, router: MainEventsListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
