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
    
    let nextMonthButton: UIButton = {
        let nextMonthButton = UIButton()
        nextMonthButton.setImage(UIImage.Calendar.nextMonthbutton, for: .normal)
        return nextMonthButton
    }()
    
    let previousMonthButton: UIButton = {
        let previousMonthButton = UIButton()
        previousMonthButton.setImage(UIImage.Calendar.previousMonthButton, for: .normal)
        return previousMonthButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        backgroundColor = .none
        addSubview(nextMonthButton)
        addSubview(previousMonthButton)
        
        nextMonthButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        previousMonthButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    func setUpConstraints() {
        previousMonthButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().inset(Constants.Offset.offset3)
            make.leading.bottom.equalToSuperview()
        }
        
        nextMonthButton.snp.makeConstraints{make in
            make.bottom.equalToSuperview().inset(Constants.Offset.offset3)
            make.trailing.equalToSuperview()
        }
    }
}