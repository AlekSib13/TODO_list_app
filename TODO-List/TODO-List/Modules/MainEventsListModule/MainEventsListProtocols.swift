//
//  MainEventsListProtocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

protocol MainEventsListViewControllerProtocol: class {}

protocol MainEventsListPresenterProtocol: class, UIPageViewControllerDataSource, UIPageViewControllerDelegate {}

protocol MainEventsListInteractorProtocol: class {}

protocol MainEventsListRouterProtocol: class {}


protocol MainEventsListCurrentListViewControllerProtocol {}

protocol MainEventsListPageViewControllerProtocol {}
