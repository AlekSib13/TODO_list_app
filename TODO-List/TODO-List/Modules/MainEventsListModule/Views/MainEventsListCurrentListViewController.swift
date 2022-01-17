//
//  MainEventsListCurrentListViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 17.01.2022.
//

import Foundation
import UIKit
import SnapKit

class MainEventsListCurrentListViewController: UIViewController,  MainEventsListCurrentListViewControllerProtocol  {
    
    var pageIndex = 0
    
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
