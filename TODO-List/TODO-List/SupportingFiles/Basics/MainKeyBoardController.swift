//
//  MainKeyBoardController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 14.02.2022.
//

import Foundation
import UIKit

protocol MainKeyBoardControllerDelegate: class {
    func keyBoardControllerKeyBoardWillShow(keyBoardController: MainKeyBoardController, keyBoardFrame: CGRect)
    func keyBoardControllerKeyBoardWillHide()
}


class MainKeyBoardController: NSObject {
    
    weak var textView: UITextView?
    weak var delegate: MainKeyBoardControllerDelegate?
    
    
    
    init(textView: UITextView, delegate: MainKeyBoardControllerDelegate) {
        self.textView = textView
        self.delegate = delegate
    }
    
    
    func beginListeningForKeyBoard() {
        registerForNotifications()
    }
    
    func endListeningForKeyBoard() {
        setKeyBoardView(hidden: true)
        unregisterForNotifications()
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyBoardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyBoardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyBoardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func didReceiveKeyBoardWillShowNotification(_ notification: Notification) {
        guard let delefate = delegate, let userInfo = notification.userInfo, let keyBoardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        
        if keyBoardSize.isNull {return}
        
        delegate?.keyBoardControllerKeyBoardWillShow(keyBoardController: self, keyBoardFrame: keyBoardSize)
    }
    
    
    @objc func didReceiveKeyBoardWillHideNotification(_ notification: Notification) {
        delegate?.keyBoardControllerKeyBoardWillHide()
    }
    
    

    @objc func didReceiveKeyBoardWillChangeFrame(_ notification: Notification) {}
    
    
    private func unregisterForNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setKeyBoardView(hidden: Bool) {
        
    }
}
