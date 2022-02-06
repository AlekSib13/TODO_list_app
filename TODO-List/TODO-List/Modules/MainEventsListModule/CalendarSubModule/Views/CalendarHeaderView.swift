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
        monthLabel.tintColor = Constants.Colour.brickBrown
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
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = .none
        return separatorView
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
    
    private var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate)
        }
    }
    
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
        addSubview(separatorView)
        configureWeekDays()
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func configureWeekDays() {
        
    }
    
    func setUpConstraints() {
        closeButton.snp.makeConstraints{make in
            make.trailing.equalToSuperview().inset(Constants.Offset.offset8)
            make.top.equalToSuperview().inset(Constants.Offset.offset8)
        }
    }
    
    @objc func closeButtonTapped() {
        delegate?.closeCalendar()
    }
}
