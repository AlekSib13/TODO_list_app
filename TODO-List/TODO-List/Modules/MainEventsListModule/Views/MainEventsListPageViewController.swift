//
//  MainEventsListPageViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 17.01.2022.
//

import Foundation
import UIKit
import AsyncDisplayKit

class MainEventsListPageViewController: UIPageViewController, MainEventsListPageViewControllerProtocol {
    
    let vc: MainEventsListCurrentListViewControllerProtocol
    let vcDelegate: MainEventsListPresenterProtocol?
    
    init(delegate: MainEventsListPresenterProtocol?) {
        self.vc = MainEventsListCurrentListViewController(pageIndex: 0)
        self.vcDelegate = delegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentVCDataSourceAndDelegate()
        guard let currentVC = vc as? ASDKViewController else {return}
        self.setViewControllers([currentVC], direction: .forward, animated: true, completion: nil)
        configureView()
    }
    
    func setCurrentVCDataSourceAndDelegate() {
        vc.tableNode.delegate = vcDelegate
        vc.tableNode.dataSource = vcDelegate
    }
    
    func configureView() {
        self.view.layer.cornerRadius = Constants.Size.size10
        view.layer.borderWidth = Constants.Size.size1
        view.layer.borderColor = Constants.Colour.defaultSystemWhite.cgColor
    }
}
