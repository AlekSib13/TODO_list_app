//
//  MainEventsListPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit
import AsyncDisplayKit

class MainEventsListPresenter: NSObject, MainEventsListPresenterProtocol {
   
    weak var view: MainEventsListViewControllerProtocol?
    let interactor: MainEventsListInteractorProtocol
    let router: MainEventsListRouterProtocol
    let timeConverter = TimeConverterHelper()
    
    init(view: MainEventsListViewControllerProtocol, interactor: MainEventsListInteractorProtocol, router: MainEventsListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        print("dates: \(interactor.itemSections)")
        return interactor.itemSections.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let date = interactor.itemSections[section]
        let number = interactor.items.filter({($0.eventDate ?? "") == date}).count
        return number
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let date = interactor.itemSections[indexPath.section]
        let item = interactor.items.filter({($0.eventDate ?? "") == date})[indexPath.row]
        return EventListCell(item: item)
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let date = interactor.itemSections[indexPath.section]
        let item = interactor.items.filter({($0.eventDate ?? "") == date})[indexPath.row]
        //MARK: TODO: rename everywhere from NewEvent to Event
        view?.showItemActionSheet(item: item)
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let deletion = UIContextualAction.init(style: .destructive, title: "delete", handler: {_,_,_ in
//            //MARK: stopped here -> should be: deletion from db + NotificationCenter.default.post ...
//            guard let cell = tableView.cellForRow(at: indexPath), let aSTableNode = cell as? ASCellNode, let eventCell = aSTableNode as? EventListCell else {return}
//            print("id from twooo: \(eventCell.item.id)")
//
//        })
//
//        let markImportant = UIContextualAction.init(style: .normal, title: "important", handler: {_,_,_ in })
//
//        let swipeActions = UISwipeActionsConfiguration.init(actions: [deletion, markImportant])
//
//        return swipeActions
//    }

    

    

    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: Constants.Offset.offset0, y: Constants.Offset.offset0, width: tableView.frame.width, height: Constants.Size.size30))
        
        let dateLabel: UILabel = {
            let dateLabel = UILabel()
            dateLabel.text = interactor.itemSections[section]
            dateLabel.font = UIFont.systemFont(ofSize: Constants.FontSize.font17, weight: .bold)
            dateLabel.textColor = Constants.Colour.brickBrown
            return dateLabel
        }()
        
        sectionHeaderView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints{make in
            make.leading.equalToSuperview().offset(Constants.Offset.offset15)
            make.centerY.equalToSuperview()
        }
        
        return sectionHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Size.size30
    }
    
    func saveTime(date: Date) {
        
        let localTime = timeConverter.convertTimeToLocal(date: date)
        print("this is local saved time: \(localTime)")
    }
    
    
    func openCalendar() {
        router.openCalendarModule()
    }
    
    func saveTimeAndText(eventInfo: (String, String)?) {
        view?.hideEventView()
        
        guard let eventInfo = eventInfo else {return}
        interactor.saveTimeAndText(eventInfo: eventInfo) {
            interactor.saveNewEvent()
        }
    }
    
    func showPlaceHolderNoData(){
        print("here will be placeholder call")
    }
    
    func saveCalendarDate(chosenDate: String) {
        let dateFormatter = TimeConverterHelper()
        //MARK: maybe show new date once the user chooses it in the calendar, and not once he presses "close button"
        if let chosenDateInNewFormat = dateFormatter.changeDateFormat(date: chosenDate) {
            view?.showCalendarDate(chosenDate: chosenDateInNewFormat)
        }
        interactor.saveCalendarDate(chosenDate: chosenDate)
    }
    
}
