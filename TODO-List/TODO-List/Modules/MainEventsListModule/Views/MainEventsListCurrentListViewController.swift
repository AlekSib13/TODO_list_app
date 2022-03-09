//
//  MainEventsListCurrentListViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 17.01.2022.
//

import Foundation
import UIKit
import SnapKit
import AsyncDisplayKit

class MainEventsListCurrentListViewController: ASDKViewController<ASDisplayNode>,  MainEventsListCurrentListViewControllerProtocol  {
    
    let tableNode: ASTableNode = {
        let tableNode = ASTableNode(style: .grouped)
        tableNode.backgroundColor = Constants.Colour.lightYellow
        tableNode.view.contentInsetAdjustmentBehavior = .never
        tableNode.view.separatorInset = .zero
        return tableNode
    }()
    
    var pageIndex = 0
    
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
        super.init(node: tableNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotifications()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Notification.Name.eventsTableReadyForReload, object: nil)
    }
    
    @objc func reloadData() {
        tableNode.reloadData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.eventsTableReadyForReload, object: nil)
    }
}
