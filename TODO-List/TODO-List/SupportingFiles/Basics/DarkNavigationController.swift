//
//  DarkNavigationController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 15.01.2022.
//

import Foundation
import UIKit

class DarkNavigationController: UINavigationController {
    
    override var  preferredStatusBarStyle: UIStatusBarStyle {.darkContent}
    override var  childForStatusBarStyle: UIViewController? {topViewController}
}
