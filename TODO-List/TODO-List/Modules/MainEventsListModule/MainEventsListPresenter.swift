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
    
    private var changebleRow: (Int, Int)?
    private var changebleEvent: NewEvent?
    
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
        changebleRow = (indexPath.section, indexPath.row)
        changebleEvent = item
//        view?.showItemActionSheet(item: item)
        view?.showItemActionSheet(important: item.eventImportance)
    }
    

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
            changebleEvent == nil ? interactor.saveNewEvent() : interactor.modifyEvent(eventId: changebleEvent?.id)
                //interactor.modifyEvent(event: changebleEvent)
            changebleEvent = nil
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
    
    func insertNewEvent(atIndex: (Int,Int)) {
        let dataToPass = (atIndex: atIndex, numberOfSections: interactor.itemSections.count)
        NotificationCenter.default.post(name: Notification.Name.eventTableNewEventInsertion, object: dataToPass)
    }
    
    func deleteEvent() {
        guard let event = changebleEvent else {return}
        interactor.deleteEvent(event: event)
    }
    
    func eventDeleted() {
        guard let changebleRow = changebleRow else {return}
        let dataToPass = (atIndex: changebleRow, numberOfSections: interactor.itemSections.count)
        NotificationCenter.default.post(name: Notification.Name.eventDeletion, object: dataToPass)
    }
    
    func openEventForModification() {
        guard let event = changebleEvent, let date = event.eventDate else {return}
        let dataToShow = (date: event.eventDate, time: event.eventTime, text: event.eventText, importance: event.eventImportance)
        view?.showEvent(withData: dataToShow)
        saveCalendarDate(chosenDate: date)
    }
}
