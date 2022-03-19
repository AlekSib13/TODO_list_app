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
        tableNode.isUserInteractionEnabled = true
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(insertNewEvent(_:)), name: Notification.Name.eventTableNewEventInsertion, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteEvent(_:)), name: Notification.Name.eventDeletion, object: nil)
    }
    
    @objc func reloadData() {
        tableNode.reloadData()
    }
    
    @objc func insertNewEvent(_ notification: Notification) {
        //MARK: test emojeys insertion into realmdb
        guard let ((sectionNumber, sectionRow), numberOfSection) = notification.object as? ((Int, Int), Int) else {return}
        
        tableNode.performBatch(animated: true, updates: {
            if tableNode.numberOfSections < numberOfSection {
                tableNode.insertSections(IndexSet.init(integer: sectionNumber), with: .automatic)
            }
            tableNode.insertRows(at: [IndexPath(row: sectionRow, section: sectionNumber)], with: .automatic)
            
        }, completion: nil)
    }
    
    @objc func deleteEvent(_ notification: Notification) {
        guard let ((sectionNumber, sectionRow), numberOfSection) = notification.object as? ((Int, Int), Int) else {return}
        
        tableNode.performBatch(animated: true, updates: {
            if tableNode.numberOfSections > numberOfSection {
                tableNode.deleteSections(IndexSet.init(integer: sectionNumber), with: .automatic)
            }
            tableNode.deleteRows(at: [IndexPath(row: sectionRow, section: sectionNumber)], with: .automatic)
            
        }, completion: nil)
    }
    
    @objc func updateEvent(_ notification: Notification) {
        guard let ((sectionNumber, sectionRow), numberOfSection) = notification.object as? ((Int, Int), Int) else {return}
        
        tableNode.performBatch(animated: true, updates: {
            if tableNode.numberOfSections < numberOfSection {
                
            } else if tableNode.numberOfSections > numberOfSection{
                
            } else //and if the number of sections didn't change? + 1/ -1
            {}



        }, completion: nil)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.eventsTableReadyForReload, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.eventTableNewEventInsertion, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.eventDeletion, object: nil)
    }
}
