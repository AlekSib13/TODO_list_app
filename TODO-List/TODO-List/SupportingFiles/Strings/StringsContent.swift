//
//  StringsContent.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import Foundation

struct StringsContent {
    
    //MARK: TODO - move 7 properties below to separate struct within StringsContent
    static let toDoLabel = "My TODO List"
    static let enterEmail = "Enter @email"
    static let enterName = "Enter name"
    
    static let tempMotivationText = "Time is what we want most, but what we use worst"
    static let tempMotivationTextAuthor = "William Penn"
    static let letsGo = "Let's go"
    static let Go = "Go!"
    
    struct MainTabBar {
        static let events = "Events"
        static let settings = "Settings"
    }
    
    struct EventsList {
        static let addEvent = "+"
        static let saveEvent = "save"
        static let insertYourReminder = "Insert your reminder"
    }
    
    struct Identifiers {
        static let calendarCellIdentifier = "CalendarCellIdentifier"
    }
    
    struct Hints {
        static let tapToSelect = "Tap to select"
    }
}
