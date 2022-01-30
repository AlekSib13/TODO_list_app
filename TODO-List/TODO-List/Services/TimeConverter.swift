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
}
