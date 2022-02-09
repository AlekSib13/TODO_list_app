//
//  Constants.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation
import UIKit

struct Constants {
    struct FontSize {
        static let font10: CGFloat = 10
        static let font12: CGFloat = 12
        static let font15: CGFloat = 15
        static let font17: CGFloat = 17
        static let font20: CGFloat = 20
        static let font30: CGFloat = 30
    }
    
    struct Offset {
        static let offsetMinus90: CGFloat = -90
        static let offsetMinus15: CGFloat = -15
        static let offsetMinus10: CGFloat = -10
        static let offsetMinus5: CGFloat = -5
        
        static let offsetMinus2: CGFloat = -2
        
        static let offset1: CGFloat = 1
        static let offset2: CGFloat = 2
        static let offset3: CGFloat = 3
        static let offset4: CGFloat = 4
        
        static let offset5: CGFloat = 5
        static let offset8: CGFloat = 8
        
        static let offset10: CGFloat = 10
        static let offset12: CGFloat = 12
        static let offset15: CGFloat = 15
        static let offset17: CGFloat = 17
        static let offset20: CGFloat = 20
        
        static let offset25: CGFloat = 25
        static let offset30: CGFloat = 30
        static let offset35: CGFloat = 35
        
        static let offset40: CGFloat = 40
        static let offset50: CGFloat = 50
        static let offset60: CGFloat = 60
        static let offset70: CGFloat = 70
        static let offset90: CGFloat = 90
        
        static let offset150: CGFloat = 150
        static let offset200: CGFloat = 200
        static let offset225: CGFloat = 225
        
        static let offset250: CGFloat = 250
        static let offset300: CGFloat = 300
        static let offset325: CGFloat = 325
    }
    
    struct Size {
        static let size1: CGFloat = 1
        static let size2: CGFloat = 2
        static let size3: CGFloat = 3
        static let size5: CGFloat = 5
        static let size10: CGFloat = 10
        
        static let size15: CGFloat = 15
        static let size17: CGFloat = 17
        static let size20: CGFloat = 20
        
        static let size25: CGFloat = 25
        static let size30: CGFloat = 30
        static let size34: CGFloat = 34
        static let size40: CGFloat = 40
        static let size50: CGFloat = 50
        static let size60: CGFloat = 60
        
        static let size70: CGFloat = 70
        static let size75: CGFloat = 75
        static let size170: CGFloat = 170
        static let size200: CGFloat = 200
        static let size250: CGFloat = 250
        
        static let size270: CGFloat = 270
        static let size286: CGFloat = 286
        
        static let multipliedBy05: CGFloat = 1/2
        static let multipliedBy1Point2: CGFloat = 1.2
    }
    
    struct Colour {
        static let defaultSystemGray = UIColor.gray
        static let defaultSystemWhite = UIColor.white
        static let defaultSystemDarkGray = UIColor.darkGray
        
        static let sandYellow = UIColor(red: 252/255, green: 221/255, blue: 118/255, alpha: 1.0)
        static let sunriseYellow = UIColor(red: 255/255, green: 207/255, blue: 72/255, alpha: 1.0)
        static let peachYellow = UIColor(red: 250/255, green: 223/255, blue: 173/255, alpha: 1.0)
        static let lightYellow = UIColor(red: 253/255, green: 234/255, blue: 168/255, alpha: 1.0)
        static let creamYellow = UIColor(red: 255/255, green: 253/255, blue: 208/255, alpha: 1.0)
        static let lemonCreamYellow = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
        
        static let brickBrown = UIColor(red: 136/255, green: 69/255, blue: 53/255, alpha: 1.0)
        static let brickBrownLighter075 = UIColor(red: 136/255, green: 69/255, blue: 53/255, alpha: 0.75)
        static let brickBrownLighter05 = UIColor(red: 136/255, green: 69/255, blue: 53/255, alpha: 0.5)
        
        //MARK: TODO: test various colours, to see, which look better: brown or orange tons
        
        static let mangoTangoOrange = UIColor(red: 255/255, green: 130/255, blue: 67/255, alpha: 1.0)
        static let mangoTangoOrangeLighter = UIColor(red: 255/255, green: 130/255, blue: 67/255, alpha: 0.75)
    }
    
    struct tabBarImageInsets {
        static let tabImageInset = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
    
    enum WeekDays: String {
        case Monday = "Mo"
        case Tuesday = "Tu"
        case Wednesday = "We"
        case Thursday = "Th"
        case Friday = "Fr"
        case Saturday = "Sa"
        case Sunday = "Su"
        
        static func returnWeekday(weekDayNumber: Int) -> String {
            switch weekDayNumber {
            case 1:
                return WeekDays.Sunday.rawValue
            case 2:
                return WeekDays.Monday.rawValue
            case 3:
                return WeekDays.Tuesday.rawValue
            case 4:
                return WeekDays.Wednesday.rawValue
            case 5:
                return WeekDays.Thursday.rawValue
            case 6:
                return WeekDays.Friday.rawValue
            default:
                break
            }
            return WeekDays.Saturday.rawValue
        }
    }
}
