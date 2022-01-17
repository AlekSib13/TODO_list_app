//
//  MainSettingsViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

class MainSettingsViewController: BasicViewController, MainSettingsViewControllerProtocol {
    
    var presenter: MainSettingsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
