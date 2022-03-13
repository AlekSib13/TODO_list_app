//
//  MainEventsViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

class MainEventsListViewController: BasicViewController, MainEventsListViewControllerProtocol, MainKeyBoardControllerDelegate {
   
    var presenter: MainEventsListPresenterProtocol?
    var eventsListView: MainEventsListPageViewControllerProtocol?
    
    
    //MARK: Clean, some ofth variables are excessive
    var savedMinYForConstraints: CGFloat?
    var keyBoardAllowedNumOfExtraOffsets = 1
    var currentkeyBoardOffsetCounter = 0
    
    var keyBoardHight: CGFloat?
    var previousKeyBoardOffsetStored: CGFloat?
    
    
    
    //MARK: TODO - put views into stack
    
    private let addEventButton: UIButton = {
//       let addEventButton = UIButton()
        let addEventButton = UIButton(frame: CGRect(x: Constants.Offset.offset10, y: Constants.Offset.offset280, width: Constants.Offset.offset40, height: Constants.Offset.offset40))
        //MARK: TODO ->  test ui on earlier iphone versions (less, than X)
        addEventButton.backgroundColor = Constants.Colour.lightOrange
        addEventButton.setTitle(StringsContent.EventsList.addEvent, for: .normal)
        addEventButton.setTitleColor(Constants.Colour.lightYellow, for: .normal)
        addEventButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.FontSize.font20, weight: .medium)
        addEventButton.titleLabel?.textAlignment = .center
        addEventButton.layer.borderColor = UIColor.white.cgColor
        addEventButton.layer.borderWidth = Constants.Size.size1
        addEventButton.layer.cornerRadius = Constants.Size.size20
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
        //MARK: TODO: implement to each view, where tag is used:
//        addEventButton.tag = Constants.addEventButtonState.plusSymbol.rawValue
        return addEventButton
    }()
    
    private let newEventView = EventFieldView()
    //MARK: TODO eliminate the bug: the text in the textview goes above when pressing enter
    
    private lazy var keyBoard = MainKeyBoardController(textView: newEventView.eventTextField, delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsListView = MainEventsListPageViewController(delegate: presenter)
        configureView()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        keyBoard.beginListeningForKeyBoard()
        hideKeyBoardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyBoard.endListeningForKeyBoard()
    }
    
    func configureView() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        view.addSubview(eventsListView.view)
        view.addSubview(addEventButton)
        view.addSubview(newEventView)
        
        newEventView.isHidden = true
        
        setDataSourceAndDelegates()
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpConstraints() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        eventsListView.view.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(Constants.Offset.offset325)
            make.left.equalToSuperview().offset(Constants.Offset.offset10)
            make.right.equalToSuperview().offset(Constants.Offset.offsetMinus10)
            make.bottom.equalToSuperview().offset(Constants.Offset.offsetMinus90)
        }
        
        newEventView.frame = CGRect(x: addEventButton.frame.minX, y: addEventButton.frame.maxY + Constants.Offset.offset5, width: UIScreen.main.bounds.width - 2 * addEventButton.frame.minX, height: Constants.Size.size250)
    }
    
    
    func setDataSourceAndDelegates() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        eventsListView.dataSource = presenter
        eventsListView.delegate = presenter
        
        newEventView.delegate = presenter
    }
    
    
    @objc func addEventButtonTapped() {
        switch addEventButton.tag {
        case Constants.addEventButtonState.plusSymbol.rawValue:
            addEventButton.tag = Constants.addEventButtonState.saveSign.rawValue
            adjustAndAnimateEventButtonContsraints()
        case Constants.addEventButtonState.saveSign.rawValue:
            addEventButton.tag = Constants.addEventButtonState.plusSymbol.rawValue
            saveEventButtonTapped()
        default:
            break
        }
    }
    
    
    func adjustAndAnimateEventButtonContsraints() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.addEventButton.transform = CGAffineTransform(rotationAngle: .pi)
                self.addEventButton.frame.origin.x += eventsListView.view.frame.width / 2
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.addEventButton.frame = CGRect(x: eventsListView.view.frame.minX, y: eventsListView.view.frame.minY - Constants.Offset.offset45, width: eventsListView.view.frame.width, height: Constants.FontSize.font40)
                self.addEventButton.layer.cornerRadius = Constants.Size.size10
            })
        }){ _ in
            self.showEventView()
        }
    }
    
    
    func showEventView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.newEventView.layer.opacity = 0.0
            self.newEventView.isHidden = false
            self.newEventView.layer.opacity = 1
        }, completion: nil)
    }
    
    func keyBoardControllerKeyBoardWillShow(keyBoardController: MainKeyBoardController, keyBoardFrame: CGRect) {
        //MARK: TODO: reconsider all of the constraints: thet should anchor to the top of the screen (x:0, y:0) in order to make of the constarints consistent to each other and get rid of the supporting variables
        
        //MARK: TODO: eliminate the bug, which happens if the calendar was opened after the keyboard had been opened: if the calendar is closed the textview stays above and there is an extra space between it and the keyboard. This bug might be solved, should the keyboard been closed after the calendar is pushed, so that the textview restores its initial constraints before the calendar opens
        
        //MARK: TODO: eliminate the bug: after entering smth into textview press return on the keyboard and then press textview: the textview will go up
        //MARK: TODO: eliminate bug, which happens from time to time: sometime before the first insertion of the text (after click on textview),there is extar space between keyboard and textview itself
        //MARK: TODO: eliminate bug: ipen newevent, insert text, insert smile, presss time picker: newevent view does not drop closser to keyboard
        
        changeConstraints(verticalOffset: keyBoardFrame.minY - Constants.Offset.offset30)
    }

    
    func keyBoardControllerKeyBoardWillHide() {
        savedMinYForConstraints = nil
        keyBoardHight = nil}
        
    
    
    func changeConstraints(verticalOffset: CGFloat) {
        let value = newEventView.frame.maxY - verticalOffset
        newEventView.frame.origin.y -= value
        addEventButton.frame.origin.y -= value
    }
    
    
    func restoreConstraints() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        addEventButton.frame.origin.y = Constants.Offset.offset280
        newEventView.frame.origin.y = addEventButton.frame.maxY + Constants.Offset.offset5
    }
    
    
    func saveEventButtonTapped() {
        dismissKeyBoard()
        newEventView.retrieveInformationToSave()
    }
    
    func hideKeyBoardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyBoard() {
        view.endEditing(true)
        previousKeyBoardOffsetStored = nil
        restoreConstraints()
    }
    
    func showCalendarDate(chosenDate: String) {
        for element in newEventView.subviews {
            if element is UIStackView {
                let stack = element
                for element in stack.subviews {
                    //MARK: TODO: optimize the code
                    if 1...6 ~= element.tag, element.subviews.count == 1, let label = element.subviews.first, let labelElement = label as? UILabel {
                        let index = chosenDate.index(chosenDate.startIndex, offsetBy: element.tag - 1, limitedBy: chosenDate.endIndex)
                        guard let index = index else {return}
                        let dateValue = chosenDate[index]
                        labelElement.text = dateValue.description
                    }
                }
            }
        }
    }
    
    func hideEventView() {
        UIView.animate(withDuration: 1.0, animations: {
            self.newEventView.layer.anchorPoint = CGPoint(x: 1, y: -1)
            self.newEventView.transform = CGAffineTransform(rotationAngle: -.pi/2)
            
        }){ _ in
            self.restoreEventView()
            self.restoreAddEventButton()
        }
    }
    
    func restoreAddEventButton() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}

        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.addEventButton.frame = CGRect(x: eventsListView.view.frame.midX, y: eventsListView.view.frame.minY - Constants.Offset.offset45, width: Constants.Size.size40, height: Constants.Size.size40)
                self.addEventButton.layer.cornerRadius = Constants.Size.size20
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.addEventButton.transform = CGAffineTransform(rotationAngle: -.pi)
                self.addEventButton.frame.origin.x -= eventsListView.view.frame.width / 2
                })
        }, completion: nil)
    }
    
    
    func restoreEventView() {
        self.newEventView.isHidden = true
        self.newEventView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.newEventView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
        self.newEventView.refreshAll()
    }
}

