//
//  Images+Assets.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 15.01.2022.
//

import Foundation
import UIKit

extension UIImage {
    
    struct MainTabBar {
        static let eventsList = {UIImage(named: "toDoList")}()
        static let settings = {UIImage(named: "settings")}()
    }
    
    struct MainMenu {
        static let calendarV1 = {UIImage(named: "calendar_v1")}()
        static let calendarV2 = {UIImage(named: "calendar_v2")}()
    }
}
