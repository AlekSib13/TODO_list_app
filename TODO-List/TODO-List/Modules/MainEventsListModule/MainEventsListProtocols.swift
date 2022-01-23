//
//  MainEventsListProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit
import AsyncDisplayKit

protocol MainEventsListViewControllerProtocol: class {}

protocol MainEventsListPresenterProtocol: class, UIPageViewControllerDataSource, UIPageViewControllerDelegate, ASTableDataSource, ASTableDelegate {}

protocol MainEventsListInteractorProtocol: class {}

protocol MainEventsListRouterProtocol: class {}


protocol MainEventsListCurrentListViewControllerProtocol {
    var tableNode: ASTableNode {get}
}

protocol MainEventsListPageViewControllerProtocol {}
