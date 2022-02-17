//
//  AddEventButton.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 24.01.2022.
//

import Foundation
import UIKit
import SnapKit

class EventFieldView: UIView, UITextViewDelegate {
    
    var delegate: NewEventHandlerDelegateProtocol?
    
    //MARK: TODO - put views into stack
    
    let eventTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = Constants.Colour.lemonCreamYellow
        textField.layer.borderWidth = Constants.Size.size1
        textField.layer.borderColor = Constants.Colour.brickBrownLighter075.cgColor
        textField.layer.cornerRadius = Constants.Size.size10
        
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = Constants.Colour.brickBrown.cgColor
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowOffset = CGSize(width: Constants.Size.size5, height: Constants.Size.size3)
        textField.layer.shadowRadius = Constants.Size.size10
        
        textField.textColor = Constants.Colour.brickBrownLighter035
        textField.font = UIFont.systemFont(ofSize: Constants.Size.size17, weight: .medium)
        
        //MARK: TODO: change to localizable for language change. This commet is relevant to all of the text elements
        textField.text = StringsContent.EventsList.insertYourReminder
        
        textField.textContainerInset = UIEdgeInsets(top: Constants.Offset.offset10, left: Constants.Offset.offset5, bottom: Constants.Offset.offset10, right: Constants.Offset.offset10)
        
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
    
    let dateViewsStack: UIStackView = {
        let dateViewsStack = UIStackView()
        return dateViewsStack
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
        self.addSubview(dateViewsStack)
        
        setEventDatePicker()
        setCalendarButton()
        
        addDateViews()
        addHorizontalSeparators()
        
        eventTextField.delegate = self
    }
    
    func setEventDatePicker() {
        eventDatePicker.addTarget(self, action: #selector(timeChanged), for: .editingDidEnd)
        eventDatePicker.addTarget(self, action: #selector(eventDatePickerTapped), for: .allEvents)
    }
    
    func setCalendarButton() {
        calendarButton.transform = CGAffineTransform(scaleX: Constants.Size.multipliedBy1Point2, y:  Constants.Size.multipliedBy1Point2)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
    }
    
    
    func addHorizontalSeparators() {
        for i in 0...1 {
            let separator = UIView()
            separator.backgroundColor = Constants.Colour.brickBrownLighter05
            separator.tag = i
            addSubview(separator)
            
            switch separator.tag {
            case 0:
                separator.snp.makeConstraints {make in
                    make.leading.trailing.equalTo(dateViewsStack)
                    make.height.equalTo(Constants.Size.size1)
                    make.bottom.equalTo(calendarButton).offset(Constants.Offset.offset1)
                }
            case 1:
                separator.snp.makeConstraints {make in
                    make.leading.trailing.equalTo(dateViewsStack)
                    make.height.equalTo(Constants.Size.size1)
                    make.bottom.equalTo(calendarButton).inset(Constants.Offset.offset2)
                }
            default:
                break
            }
        }
    }
    
    
    func addDateViews() {
        for i in 0...5 {
            if  dateViewsStack.subviews.count == 2 || dateViewsStack.subviews.count == 5 {
                let separator = UIView()
                separator.backgroundColor = .none
                dateViewsStack.addArrangedSubview(separator)
                separator.snp.makeConstraints{make in
                    make.width.equalTo(Constants.Offset.offset3)
                }
            }
            let digitView = UIView()
            digitView.tag = i
            digitView.backgroundColor = Constants.Colour.lemonCreamYellow
            digitView.layer.borderColor = Constants.Colour.brickBrownLighter075.cgColor
            digitView.layer.borderWidth = Constants.Size.size1
            digitView.layer.cornerRadius = Constants.Size.size5
            dateViewsStack.addArrangedSubview(digitView)
            digitView.snp.makeConstraints{make in
                make.width.equalTo(Constants.Size.size15)
            }
            let textLabel = UILabel()
            digitView.addSubview(textLabel)
            textLabel.snp.makeConstraints{make in
                make.edges.equalToSuperview()
            }
            textLabel.textAlignment = .center
            textLabel.font = UIFont.systemFont(ofSize: Constants.FontSize.font15, weight: .medium)
            textLabel.textColor = .black
        }
    }
    
    
    func setUpConstraints() {
        
        eventDatePicker.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(Constants.Offset.offset10)
            make.leading.equalToSuperview().offset(Constants.Offset.offset8)
        }
        
        eventTextField.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(Constants.Offset.offset10)
            make.bottom.equalToSuperview().offset(Constants.Offset.offset20)
            make.top.equalToSuperview().inset(Constants.Offset.offset70)
        }
        
        calendarButton.snp.makeConstraints{make in
            make.centerY.equalTo(eventDatePicker).offset(Constants.Offset.offsetMinus2)
            make.trailing.equalTo(dateViewsStack.snp.leading).offset(Constants.Offset.offsetMinus10)
        }
        
        dateViewsStack.snp.makeConstraints {make in
            make.top.equalTo(calendarButton)
            make.trailing.equalTo(eventTextField).inset(Constants.Offset.offset8)
            make.bottom.equalTo(calendarButton).inset(Constants.Offset.offset5)
        }
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if eventTextField.text == StringsContent.EventsList.insertYourReminder {
            eventTextField.text = ""
            eventTextField.textColor = Constants.Colour.brickBrown
        }
    }
    
    func retrieveInformationToSave() {
        let timeConverter = TimeConverterHelper()
        print("some text to save: \(eventTextField.text) ")
        print("some time to save: \( timeConverter.convertTimeToLocal(date: eventDatePicker.date))")
    }
    
    
    @objc func timeChanged() {
        //MARK: perhaps this is function is not needed, since it is worth of considering the time, when user tappes save button
        delegate?.saveTime(date: eventDatePicker.date)
    }
    
    @objc func calendarButtonTapped() {
        delegate?.openCalendar()
    }
    
    @objc func eventDatePickerTapped() {
        print("date Picker Tapped")
        //MARK: the idea is to inform ViewController, that the datepicker (not textview) had been tapped, before keyboard actions were launched.
    }
}
