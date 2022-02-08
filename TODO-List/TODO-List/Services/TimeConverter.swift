//
//  TimeConverter.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 30.01.2022.
//

import Foundation

class TimeConverterHelper {
    
    func convertTimeToLocal(date: Date) -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = .current
        
        let localTime = dateFormatter.string(from: date)
        return localTime
    }
    
    func getCurrentDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dayMonthYear = dateFormatter.string(from: date)
        return dayMonthYear
    }
    
    func getFullDateFromDate(day: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        
        let date = dateFormatter.date(from: day)
        return date
    }
}
