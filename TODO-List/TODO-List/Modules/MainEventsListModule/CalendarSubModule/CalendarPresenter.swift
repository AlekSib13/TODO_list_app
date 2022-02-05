//
//  CalendarPresenter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.02.2022.
//

import Foundation

class CalendarPresenter: CalendarPresenterProtocol {
    
    weak var view: CalendarViewControllerProtocol?
    let interactor: CalendarInteractorProtocol
    let router: CalendarRouterProtocol
    
    init(view: CalendarViewControllerProtocol?,
         interactor: CalendarInteractorProtocol,
         router: CalendarRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: TODO - change selectedDate!
    private let selectedDate = Date()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    
    func viewDidLoad() {
        registerCell()
    }
    
    private func registerCell() {
        guard let collectionView = view?.calendarCollectionView else {return}
        CalendarDateCell.registerClass(into: collectionView)
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
    
    
    func dismissCalendar() {
        router.dismissCalendar()
    }
}
