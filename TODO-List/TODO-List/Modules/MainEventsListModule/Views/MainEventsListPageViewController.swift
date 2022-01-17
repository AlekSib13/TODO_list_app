//
//  MainEventsListPageViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 17.01.2022.
//

import Foundation
import UIKit

class MainEventsListPageViewController: UIPageViewController, MainEventsListPageViewControllerProtocol {
    
    let vc: MainEventsListCurrentListViewControllerProtocol
    
    init() {
        self.vc = MainEventsListCurrentListViewController(pageIndex: 0)
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentVC = vc as? UIViewController else {return}
        self.setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        configureView()
    }
    
    func configureView() {
        self.view.layer.cornerRadius = Constants.Size.size10
        view.layer.borderWidth = Constants.Size.size1
        view.layer.borderColor = Constants.Colour.defaultSystemWhite.cgColor
    }
}
