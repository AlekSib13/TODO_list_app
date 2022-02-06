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
    let interactor: CalendarInteractorProtocol
    let router: CalendarRouterProtocol
    
    
    private let selectedDate: Date
//    private let selectedDateChanged: ((Date) -> Void)
    
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
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
    
    
//    init(view: CalendarViewControllerProtocol?,
//         interactor: CalendarInteractorProtocol,
//         router: CalendarRouterProtocol, baseDate: Date, selectedDateChanged: @escaping ((Date) -> Void))
    
    init(view: CalendarViewControllerProtocol?,
         interactor: CalendarInteractorProtocol,
         router: CalendarRouterProtocol, baseDate: Date) {
        self.view = view
        self.interactor = interactor
        self.router = router
        selectedDate = baseDate
        self.baseDate = baseDate
//        self.selectedDateChanged = selectedDateChanged
    }
    
    
    //MARK: TODO - change selectedDate!
   
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
        let cell = CalendarDateCell.load(into: collectionView, for: indexPath)
        cell.configure(delegate: self, day: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
//        selectedDateChanged(day.date)
//        dismiss(animated: true, completion: nil)
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
        
        return Day(date: date, number: dateFormatter.string(from: date), isSelected: view?.calendar.isDate(date, inSameDayAs: selectedDate) ?? false, isWithinDisplayedMonth: isWithinDisplayedMonth)
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
        router.dismissCalendar()
    }
}
