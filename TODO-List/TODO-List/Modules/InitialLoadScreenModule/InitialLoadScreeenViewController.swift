//
//  InitialLoadScreeenViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 28.11.2021.
//

import UIKit
import SnapKit

class InitialLoadScreeenViewController: BasicViewController, InitialLoadScreeenViewControllerProtocol, UITextFieldDelegate {
    
    var presenter: InitialLoadScreenPresenterProtocol?
    
    private let colorfulView: UIView = {
        let colorfulView = UIView()
        colorfulView.backgroundColor = .none
        return colorfulView
    }()
    
    private let toDoLabel: UILabel = {
        let toDoLabel = UILabel()
        toDoLabel.text = StringsContent.toDoLabel
        toDoLabel.font = UIFont.boldSystemFont(ofSize: Constants.FontSize.font30)
        toDoLabel.textColor = Constants.Colour.brickBrown
        return toDoLabel
    }()
    
    private let nameField: UITextField = {
        let nameField = UITextField()
        nameField.placeholder = StringsContent.enterName
        nameField.font = UIFont.systemFont(ofSize: Constants.FontSize.font20)
        nameField.backgroundColor = Constants.Colour.defaultSystemWhite
        nameField.layer.cornerRadius = Constants.Size.size5
        return nameField
    }()
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = StringsContent.enterEmail
        emailField.font = UIFont.systemFont(ofSize: Constants.FontSize.font20)
        emailField.backgroundColor = Constants.Colour.defaultSystemWhite
        emailField.layer.cornerRadius = Constants.Size.size5
        return emailField
    }()
    
    private let credentialStack: UIStackView = {
        let credentialStack = UIStackView()
        credentialStack.axis = .vertical
        credentialStack.alignment = .center
        credentialStack.isUserInteractionEnabled = true
        return credentialStack
    }()
    
    private let fieldsSeparator: UIView = {
        let fieldsSeparator = UIView()
        fieldsSeparator.backgroundColor = Constants.Colour.defaultSystemGray
        return fieldsSeparator
    }()
    
    private let buttonSeparator: UIView = {
        let buttonSeparator = UIView()
        buttonSeparator.backgroundColor = Constants.Colour.defaultSystemGray
        return buttonSeparator
    }()
    
    private let enterButton: UIButton = {
        let enterButton = UIButton()
        enterButton.setTitle(StringsContent.letsGo, for: .normal)
        enterButton.setTitleColor(Constants.Colour.brickBrown, for: .normal)
        enterButton.backgroundColor = Constants.Colour.sunriseYellow
        enterButton.layer.cornerRadius = Constants.Size.size10
        enterButton.layer.borderWidth = Constants.Size.size1
        enterButton.layer.borderColor = Constants.Colour.defaultSystemWhite.cgColor
        enterButton.addTarget(self, action: #selector(enterTheApp), for: .touchUpInside)
        return enterButton
    }()
    
    
    // MARK: TODO - Motivation statement from the database.
    // There will be round 30 motivation statements, which would be randomly extracted each time a users enters the app. In future, perhaps, statements will be loaded from the internet should these kind of free resources exist
    private let motivationStatement: UILabel = {
        let motivationStatement = UILabel()
        motivationStatement.text = StringsContent.tempMotivationText
        motivationStatement.font = UIFont.italicSystemFont(ofSize: Constants.FontSize.font17)
        motivationStatement.textColor = Constants.Colour.brickBrown
        motivationStatement.lineBreakMode = .byWordWrapping
        motivationStatement.numberOfLines = 3
        motivationStatement.textAlignment = .right
        return motivationStatement
    }()
    
    private let motivationStatementAuthor: UILabel = {
        let motivationStatementAuthor = UILabel()
        motivationStatementAuthor.text = StringsContent.tempMotivationTextAuthor
        motivationStatementAuthor.font = UIFont.systemFont(ofSize: Constants.FontSize.font17)
        motivationStatementAuthor.textColor = Constants.Colour.brickBrown
        motivationStatementAuthor.lineBreakMode = .byWordWrapping
        motivationStatementAuthor.numberOfLines = 1
        motivationStatementAuthor.textAlignment = .right
        return motivationStatementAuthor
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: TODO - show some animation while checking if there is data about user in db and if there is -> go to next screen, and if there is not -> hide animation and propose logging in
        
        configureView()
        setUpConstraints()
    }
    
    
    private func configureView() {
        view.addSubview(colorfulView)
        colorfulView.addSubview(toDoLabel)
        colorfulView.addSubview(nameField)
        colorfulView.addSubview(credentialStack)
        credentialStack.addArrangedSubview(nameField)
        credentialStack.addArrangedSubview(fieldsSeparator)
        credentialStack.addArrangedSubview(emailField)
        credentialStack.addArrangedSubview(buttonSeparator)
        credentialStack.addArrangedSubview(enterButton)
        
        // the two viewsBelow - add them to vertical stack as it was made with credentialStack
        colorfulView.addSubview(motivationStatement)
        colorfulView.addSubview(motivationStatementAuthor)
        
        
        nameField.delegate = self
        emailField.delegate = self
    }
    
    private func setUpConstraints() {
        colorfulView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
        
        toDoLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(Constants.Offset.offset150)
            make.centerX.equalToSuperview()
        }

        credentialStack.snp.makeConstraints {make in
            make.top.equalTo(toDoLabel.snp.bottom).offset(Constants.Offset.offset35)
            make.leading.equalTo(toDoLabel).offset(Constants.Offset.offset10)
            make.trailing.equalTo(toDoLabel).offset(Constants.Offset.offsetMinus10)
        }
        
        nameField.snp.makeConstraints {make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(Constants.Size.size170)
        }
        
        fieldsSeparator.snp.makeConstraints {make in
            make.height.equalTo(Constants.Offset.offset15)
        }

        emailField.snp.makeConstraints {make in
            make.leading.equalToSuperview()
            make.top.equalTo(fieldsSeparator.snp.bottom)
            make.width.equalTo(Constants.Size.size170)
        }
        
        buttonSeparator.snp.makeConstraints {make in
            make.top.equalTo(emailField.snp.bottom)
            make.height.equalTo(Constants.Offset.offset40)
        }
        
        enterButton.snp.makeConstraints {make in
            make.width.equalTo(Constants.Size.size75)
            make.centerX.equalTo(emailField)
            make.bottom.equalToSuperview()
            
        }
        
        motivationStatement.snp.makeConstraints {make in
            make.top.equalTo(credentialStack.snp.bottom).offset(Constants.Offset.offset300)
            make.leading.equalTo(colorfulView.snp.centerX)
            make.trailing.equalToSuperview().offset(Constants.Offset.offsetMinus15)
        }
        
        motivationStatementAuthor.snp.makeConstraints {make in
            make.top.equalTo(motivationStatement.snp.bottom).offset(Constants.Offset.offset10)
            make.trailing.equalToSuperview().offset(Constants.Offset.offsetMinus15)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("ok")
        return true
    }
    
    @objc func enterTheApp() {
        print("I am entering")
        guard let name = nameField.text, !name.isEmpty else {
            animateNameField()
            return
        }
        presenter?.enterTheApp(name: name, email: emailField.text)
    }
    
    func animateNameField() {
    }
}
