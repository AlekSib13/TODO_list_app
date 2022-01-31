//
//  AddEventButton.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit

class EventFieldView: UIView {
    
    var delegate: NewEventHandlerDelegateProtocol?
    
    //MARK: TODO - put views into stack
    
    let eventTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = Constants.Colour.lemonCreamYellow
        textField.layer.borderWidth = Constants.Size.size1
        textField.layer.borderColor = Constants.Colour.brickBrownLighter.cgColor
        textField.layer.cornerRadius = Constants.Size.size10
        
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = Constants.Colour.brickBrown.cgColor
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowOffset = CGSize(width: Constants.Size.size5, height: Constants.Size.size3)
        textField.layer.shadowRadius = Constants.Size.size10
        return textField
    }()
    
    let eventDatePicker: UIDatePicker = {
        let eventDatePicker = UIDatePicker()
        eventDatePicker.datePickerMode = .time
        eventDatePicker.preferredDatePickerStyle = .inline
        return eventDatePicker
    }()
    
    //MARK: TODO: add animation: change button image, when pressed
    let calendarButton: UIButton = {
        let calendarButton = UIButton()
        calendarButton.setImage(UIImage.MainMenu.calendarV2, for: .normal)
        return calendarButton
    }()
    
    //MARK: TODO: add field nearby calendar, which takes the chosen date from calendar as soon as user closes the calendar
    
//    let calendarVC = CalendarViewController()
    
    // alternative version of Save Button
//    let saveButton: UIButton = {
//        let saveButton = UIButton()
//        saveButton.backgroundColor = Constants.Colour.lemonCreamYellow
//        saveButton.layer.borderWidth = Constants.Size.size1
//        saveButton.layer.borderColor = Constants.Colour.brickBrownLighter.cgColor
//        saveButton.layer.cornerRadius = Constants.Size.size10
//        saveButton.setTitle(StringsContent.EventsList.saveEvent, for: .normal)
//        saveButton.setTitleColor(Constants.Colour.brickBrownLighter, for: .normal)
//        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.FontSize.font20, weight: .medium)
//        return saveButton
//    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        self.backgroundColor = Constants.Colour.mangoTangoOrangeLighter
        self.layer.borderWidth = Constants.Size.size1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = Constants.Size.size10
            
        self.addSubview(eventTextField)
        self.addSubview(eventDatePicker)
        self.addSubview(calendarButton)
        //MARK: TODO - think about it: perhaps calendar should be the complete submodule with its presenter, interactor, router
//        self.addSubview(calendarVC.view)
//        self.addSubview(saveButton)
//        calendarVC.delegate = calendarDelegate
        
        setEventDatePicker()
        setCalendarButton()
    }
    
    func setEventDatePicker() {
        eventDatePicker.addTarget(self, action: #selector(timeChanged), for: .editingDidEnd)
    }
    
    func setCalendarButton() {
        calendarButton.transform = CGAffineTransform(scaleX: Constants.Size.multipliedBy1Point2, y:  Constants.Size.multipliedBy1Point2)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
    
    func setUpConstraints() {
        
        eventDatePicker.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(Constants.Offset.offset10)
            make.leading.equalToSuperview().offset(Constants.Offset.offset2)
        }
        
        eventTextField.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(Constants.Offset.offset10)
            make.bottom.equalToSuperview().offset(Constants.Offset.offset20)
            make.top.equalToSuperview().inset(Constants.Offset.offset70)
        }
        
        calendarButton.snp.makeConstraints{make in
            make.centerY.equalTo(eventDatePicker).offset(Constants.Offset.offsetMinus2)
            make.leading.equalTo(eventDatePicker.snp.trailing).offset(Constants.Offset.offset20)
        }
        
//        saveButton.snp.makeConstraints{make in
//            make.leading.trailing.equalTo(eventTextField).inset(10)
//            make.top.equalTo(eventTextField.snp.bottom)
//        }
    }
    
    
    
    @objc func timeChanged() {
        //MARK: perhaps this is function is not needed, since it is worth of considering the time, when user tappes save button
        delegate?.saveTime(date: eventDatePicker.date)
    }
    
    @objc func calendarButtonTapped() {
        delegate?.openCalendar()
    }
}
