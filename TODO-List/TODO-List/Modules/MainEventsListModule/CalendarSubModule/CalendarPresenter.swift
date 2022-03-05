//
//  CalendarPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation
import UIKit

class CalendarPresenter: NSObject, CalendarPresenterProtocol, CalendarDateCellDelegate {    
 
    weak var view: CalendarViewControllerProtocol?
    weak var delegate: CalendarExternalDelegate?
    let interactor: CalendarInteractorProtocol
    let router: CalendarRouterProtocol
    let timeConverter = TimeConverterHelper()
    
    private var selectedDate: Date
    
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            view?.updateCalendarHeader(date: baseDate)
            selectedDate = baseDate
            view?.calendarCollectionView.reloadData()
        }
    }
    
    private lazy var days = generateDaysInMonth(for: baseDate)
    private var numberOfWeeksInBaseDate: Int {
        view?.calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    
    init(view: CalendarViewControllerProtocol?,
         interactor: CalendarInteractorProtocol,
         router: CalendarRouterProtocol, baseDate: Date) {
        self.view = view
        self.interactor = interactor
        self.router = router
        selectedDate = baseDate
        self.baseDate = baseDate
    }
    
    
    //MARK: TODO: change selectedDate!
    //MARK: TODO: restrict to choose dates in past
   
    func viewDidLoad() {
        registerCell()
    }
    
    private func registerCell() {
        guard let collectionView = view?.calendarCollectionView else {return}
        CalendarDateCell.registerClass(into: collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        print("day \(day.date), isWithinMonth \(day.isWithinDisplayedMonth)")
        let cell = CalendarDateCell.load(into: collectionView, for: indexPath)
        cell.configure(delegate: self, day: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexes = collectionView.numberOfItems(inSection: indexPath.section)
        for index in 0...indexes {
            
            guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: indexPath.section)), let calendarDateCell = cell as? CalendarDateCell else {return}
            let newDate = days[index]
            if index == indexPath.row {
                if let chosenDate = view?.calendar.date(byAdding: .day, value: 1, to: newDate.date), chosenDate < Date() {
                    return
                }
                calendarDateCell.applySelectedStyle()
                selectedDate = newDate.date
            } else {
                calendarDateCell.applyDefaultStyle(isWithinDisplayedMonth: newDate.isWithinDisplayedMonth)
            }
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
    
    
    func createMonthMetaData(for baseDate: Date) throws -> MonthMetaData {
        guard let numberOfDaysInMonth = view?.calendar.range(of: .day, in: .month, for: baseDate)?.count, let dateComponents = view?.calendar.dateComponents([.year, .month], from: baseDate), let firstDayOfMonth = view?.calendar.date(from: (dateComponents)),  let firstDayOfWeek = view?.calendar.component(.weekday, from: firstDayOfMonth) else {
            throw CalendarError.monthMetaDataGeneration}
        
        return MonthMetaData(numberOfDays: numberOfDaysInMonth, monthFirstDate: firstDayOfMonth, weekFirstDayNumber: firstDayOfWeek)
    }
    
    
    //MARK: TODO: do not forget to transfer baseDate time to local one, otherwise there are situations, when it is the new day in terms of the local time, but since Date in UTC, the date itself could be in the past
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let monthMetaData = try? createMonthMetaData(for: baseDate) else {
            fatalError(CalendarError.monthMetaDataGeneration.rawValue)
        }
            
            let numberOfDaysInMonth = monthMetaData.numberOfDays
            let offsetInInitialRow = monthMetaData.weekFirstDayNumber
            let firstDateOfMonth = monthMetaData.monthFirstDate
            
            var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow)).map{day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                
                let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
                
                return generateDay(offsetBy: dayOffset, for: firstDateOfMonth, isWithinDisplayedMonth: isWithinDisplayedMonth)
                
            }
        
            days += generateStartOfNextMonth(using: firstDateOfMonth)
        
            return days
    }
    
    
    func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = view?.calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        
        let selected = view?.calendar.component(.day, from: date) == view?.calendar.component(.day, from: selectedDate) ? true : false
        
        return Day(date: date, number: dateFormatter.string(from: date), isSelected: selected, isWithinDisplayedMonth: isWithinDisplayedMonth)
    }
    
    
    func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
        guard let lastDayInMonth = view?.calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfDisplayedMonth), let lastDayInMonthDayNum = view?.calendar.component(.weekday, from: lastDayInMonth) else {return []}
        
        let additionalDays = 7 - lastDayInMonthDayNum
        guard additionalDays > 0 else {return []}
        
        let days: [Day] = (1...additionalDays).map{day in
            return generateDay(offsetBy: day, for: lastDayInMonth, isWithinDisplayedMonth: false)
        }
        
        return days
    }
    
    
    func closeCalendar() {
        saveDate()
        router.dismissCalendar()
    }
    
    func openNextMonth() {
        guard let date = view?.calendar.date(byAdding: .month, value: 1, to: selectedDate) else {return}
        view?.hidePreviousMonthButton(hide: false)
        baseDate = date
    }
    
    func openPreviousMonth() {
        guard let date = view?.calendar.date(byAdding: .month, value: -1, to: selectedDate) else {return}
        if let chosenMonth = view?.calendar.component(.month, from: date), let currentMonth = view?.calendar.component(.month, from: Date()), chosenMonth == currentMonth {
            view?.hidePreviousMonthButton(hide: true)
        }
        baseDate = date
    }
    
    func saveDate() {
        let timeConverter = TimeConverterHelper()
        let chosenDate = timeConverter.getCurrentDate(date: selectedDate)
        delegate?.saveCalendarDate(chosenDate: chosenDate)
    }
}
