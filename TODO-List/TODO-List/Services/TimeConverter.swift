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
    
    func convertTimeDateToLocal(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'h:mm a"
        dateFormatter.calendar = .current
        
        let localTimeDate = dateFormatter.string(from: date)
        return localTimeDate
    }
    
    func getCurrentDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        //MARK: checkABit after 23:59 pm - it should show a new day, not the previous one, otherwise use convertTimeDateToLocal, but take only day
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
        
        //MARK: TODO, perhaps it would be required to change the oder of the date: right now in view date starts with the day meanwhile in tablenode it starts with the year
        let dateSubstrings = date.split(separator: "-")
        guard let year = dateSubstrings.first, let yearStartIndex = year.index(year.startIndex, offsetBy: year.count - 2, limitedBy: year.endIndex) else {return nil}
        let updatedDate = String(dateSubstrings[2]) + String(dateSubstrings[1]) + String(year[yearStartIndex...])
        
        return updatedDate
    }
}
