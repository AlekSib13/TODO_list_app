//
//  EventListCell.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 01.03.2022.
//

import Foundation
import UIKit
import AsyncDisplayKit

//class EventListCell: UITableViewCell, ReusableTableCell {
//    static var identifier: String = StringsContent.Identifiers.eventListIdentifier
//}


class EventListCell: ASCellNode {
    
    struct ElementsAttributes {
        static let eventTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: Constants.Size.size17, weight: .medium), .foregroundColor : Constants.Colour.brickBrown]
        static let eventDayAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: Constants.Size.size17, weight: .medium), .foregroundColor : Constants.Colour.brickBrown]
        static let eventTimeAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: Constants.Size.size17, weight: .medium), .foregroundColor : Constants.Colour.brickBrown]
    }
    
    
    let item: NewEvent
    
    let evenText: ASEditableTextNode = {
        let eventText = ASEditableTextNode()
        eventText.isUserInteractionEnabled = false
        //MARK: TODO: add ellipsis for the keys, when number of lines is more, than 3
        eventText.maximumLinesToDisplay = 3
        return eventText
    }()
    
    
    
    let eventDay: ASTextNode = {
        let eventDay = ASTextNode()
        return eventDay
    }()
    
    let eventTime: ASTextNode = {
        let eventTime = ASTextNode()
        return eventTime
    }()
    
    let eventInformationStack: ASStackLayoutSpec = {
        let eventInformationStack = ASStackLayoutSpec()
        eventInformationStack.direction = .horizontal
        eventInformationStack.horizontalAlignment = .left
        return eventInformationStack
    }()

    let dateAndTimeStack: ASStackLayoutSpec = {
        let dateAndTimeStack = ASStackLayoutSpec()
        dateAndTimeStack.direction = .vertical
        return dateAndTimeStack
    }()
    
    
    init(item: NewEvent) {
        self.item = item
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        configureCell()
    }

    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        

//        dateAndTimeStack.children = [eventTime]
//        dateAndTimeStack.spacing = Constants.Offset.offset8

        eventInformationStack.children = [eventTime,evenText]
        eventInformationStack.spacing = Constants.Offset.offset15
        

        let horizontalInsetsLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: Constants.Offset.offset10, left: Constants.Offset.offset25, bottom: Constants.Offset.offset10, right: Constants.Offset.offset10), child: eventInformationStack)

        return horizontalInsetsLayoutSpec
    }
    
    
    func configureCell() {
        view.backgroundColor = Constants.Colour.lightYellow
        
        evenText.attributedText = NSAttributedString(string: item.eventText ?? "", attributes: ElementsAttributes.eventTextAttributes)
//        eventDay.attributedText = NSAttributedString(string: item.eventDate ?? "", attributes: ElementsAttributes.eventDayAttributes)
        eventTime.attributedText = NSAttributedString(string: item.eventTime ?? "", attributes: ElementsAttributes.eventTimeAttributes)
    }
    
    
    override func layout() {
        eventTime.style.width = ASDimensionMake(UIScreen.main.bounds.width * 0.2)
        evenText.style.width = ASDimensionMake(UIScreen.main.bounds.width * 0.6)
    }
}

