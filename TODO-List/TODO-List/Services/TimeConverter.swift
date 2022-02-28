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
        //"HH:mm" - 24 hours format
        //"HH:mm:ss"
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'h:mm a"
        
        let date = dateFormatter.date(from: day)
        return date
    }
    
    func changeDateFormat(date: String) -> String? {
        let dateSubstrings = date.split(separator: "-")
        guard let year = dateSubstrings.first, let yearStartIndex = year.index(year.startIndex, offsetBy: year.count - 2, limitedBy: year.endIndex) else {return nil}
        let updatedDate = String(dateSubstrings[2]) + String(dateSubstrings[1]) + String(year[yearStartIndex...])
        
        return updatedDate
    }
}
