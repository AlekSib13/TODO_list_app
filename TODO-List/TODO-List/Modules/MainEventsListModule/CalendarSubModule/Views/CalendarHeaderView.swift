//
//  CalendarHeaderView.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 06.02.2022.
//

import Foundation
import UIKit
import SnapKit

class CalendarHeaderView: UIView {
    
    //MARK: TODO when pressing the month, the view with year months to choose should be openned (as it is for days)
    private let monthLabel: UILabel = {
        let monthLabel = UILabel()
        monthLabel.font = .systemFont(ofSize: Constants.Size.size25, weight: .bold)
        monthLabel.textColor = Constants.Colour.brickBrown
        monthLabel.text = "Month"
        monthLabel.accessibilityTraits = .header
        monthLabel.isAccessibilityElement = true
        return monthLabel
    }()
    
    private let weekDaysStackView: UIStackView = {
        let weekDaysStackView = UIStackView()
        weekDaysStackView.distribution = .fillEqually
        return weekDaysStackView
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        //MARK: TODO - experiment with various dateformat templates
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()
    
    private let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage.Calendar.calendarCloseButton, for: .normal)
        return closeButton
    }()
    
    var delegate: CalendarDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        addSubview(monthLabel)
        addSubview(weekDaysStackView)
        addSubview(closeButton)
        configureWeekDays()
        
        
        closeButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        monthLabel.text = dateFormatter.string(from: Date())
    }
    
    func configureWeekDays() {
        for number in 1...7 {
            let dayOfWeek = UILabel()
            dayOfWeek.textColor = Constants.Colour.brickBrownLighter05
            dayOfWeek.font = .systemFont(ofSize: Constants.Size.size15, weight: .medium)
            dayOfWeek.text = String(Constants.WeekDays.returnWeekday(weekDayNumber: number))
            weekDaysStackView.addArrangedSubview(dayOfWeek)
        }
    }
    
    func setUpConstraints() {
        closeButton.snp.makeConstraints{make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(monthLabel)
        }
        
        monthLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(Constants.Offset.offset8)
            make.leading.equalToSuperview().offset(Constants.Offset.offset5)
        }
        
        weekDaysStackView.snp.makeConstraints{make in
            make.leading.equalToSuperview().inset(Constants.Offset.offset12)
            make.trailing.equalToSuperview().offset(Constants.Offset.offset17)
            make.top.equalTo(closeButton.snp.bottom).offset(Constants.Offset.offset2)
        }
    }
    
    @objc func closeButtonTapped() {
        delegate?.closeCalendar()
    }
    
    func updateHeader(newDate: Date) {
        monthLabel.text = dateFormatter.string(from: newDate)
    }
}
