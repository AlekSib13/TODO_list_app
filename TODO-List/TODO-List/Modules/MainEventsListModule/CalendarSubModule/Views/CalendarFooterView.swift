//
//  CalendarFooterView.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 06.02.2022.
//

import Foundation
import UIKit

class CalendarFooterView: UIView {
    
    var delegate: CalendarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
