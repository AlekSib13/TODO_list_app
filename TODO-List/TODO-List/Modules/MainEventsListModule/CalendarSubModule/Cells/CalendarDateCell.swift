//
//  CalendarDateCell.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 04.02.2022.
//

import Foundation
import UIKit
import SnapKit

class CalendarDateCell: UICollectionViewCell, ReusableCell {
    static var identifier: String = StringsContent.Identifiers.calendarCellIdentifier
    
    var delegate: CalendarDateCellDelegate?
    
    var day: Day? {
        didSet {
            setDay()
            updateSelectionStatus()
        }
    }
    
    private let selectionBackGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = Constants.Colour.brickBrownLighter075
        
        view.layer.cornerRadius = Constants.Size.size17
        view.layer.borderWidth = Constants.Size.size1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.font17, weight: .medium)
        label.textColor = Constants.Colour.brickBrown
        return label
    }()
    
    private let accesibilityDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM, d")
        return dateFormatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        assembleCell()
    }
    
    func assembleCell() {
        configureView()
        setUpConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(selectionBackGroundView)
        contentView.addSubview(numberLabel)
    }
    
    private func setDay() {
        guard let day = day else {return}
        numberLabel.text = day.number
        accessibilityLabel = accesibilityDateFormatter.string(from: day.date)
        
    }
    
    func setUpConstraints() {
        numberLabel.snp.makeConstraints{make in
            make.centerX.centerY.equalToSuperview()
        }
        
        selectionBackGroundView.snp.makeConstraints{make in
            make.height.width.equalTo(Constants.Size.size34)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func configure(delegate: CalendarDateCellDelegate, day: Day) {
        self.day = day
        self.delegate = delegate
    }
    
    func updateSelectionStatus() {
        guard let day = day else {return}
        day.isSelected ? applySelectedStyle() : applyDefaultStyle(isWithinDisplayedMonth: day.isWithinDisplayedMonth)
    }
    
    
    func applySelectedStyle() {
        accessibilityTraits.insert(.selected)
        accessibilityHint = nil
        
        numberLabel.textColor = Constants.Colour.sandYellow
        selectionBackGroundView.isHidden = false
    }
    
    func applyDefaultStyle(isWithinDisplayedMonth: Bool) {
        accessibilityTraits.remove(.selected)
        accessibilityHint = StringsContent.Hints.tapToSelect
        
        numberLabel.textColor = isWithinDisplayedMonth ? Constants.Colour.brickBrown : Constants.Colour.brickBrownLighter05
        selectionBackGroundView.isHidden = true
    }
}
