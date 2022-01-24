//
//  MainEventsViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 12.01.2022.
//

import Foundation
import UIKit

class MainEventsListViewController: BasicViewController, MainEventsListViewControllerProtocol {
    
    var presenter: MainEventsListPresenterProtocol?
    var eventsListView: MainEventsListPageViewControllerProtocol?
    
    
    private let addEventButton: UIButton = {
       let addEventButton = UIButton()
        addEventButton.backgroundColor = Constants.Colour.brickBrown
        addEventButton.setTitle(StringsContent.EventsList.addEvent, for: .normal)
        addEventButton.setTitleColor(Constants.Colour.lightYellow, for: .normal)
        addEventButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.FontSize.font20, weight: .bold)
        addEventButton.titleLabel?.textAlignment = .center
        addEventButton.layer.borderColor = UIColor.white.cgColor
        addEventButton.layer.borderWidth = Constants.Size.size1
        addEventButton.layer.cornerRadius = Constants.Size.size20
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
        return addEventButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsListView = MainEventsListPageViewController(delegate: presenter)
        configureView()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    func configureView() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        view.addSubview(eventsListView.view)
        view.addSubview(addEventButton)

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
        
        addEventButton.snp.makeConstraints{make in
            make.bottom.equalTo(eventsListView.view.snp.top).offset(Constants.Offset.offsetMinus5)
            make.leading.equalTo(eventsListView.view)
            make.width.equalTo(Constants.Size.size40)
            make.height.equalTo(Constants.Size.size40)
        }
    }
    
    func setDataSourceAndDelegates() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        eventsListView.dataSource = presenter
        eventsListView.delegate = presenter
    }
    
    
    @objc func addEventButtonTapped() {
        print("I am tapped")
//        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        adjustAddEventButtonContsraints()
        
//        UIView.animate(withDuration: 3.0, delay: .nan, options: .curveLinear, animations: {
////            self.addEventButton.snp.makeConstraints{make in
////                make.bottom.equalTo(eventsListView.view.snp.top).offset(Constants.Offset.offsetMinus5)
////                make.leading.equalTo(eventsListView.view)
////                make.trailing.equalTo(eventsListView.view)
////                make.height.equalTo(Constants.Size.size40)
//
//            self.addEventButton.transform = CGAffineTransform(scaleX: 3, y: 1)
//            }, completion: nil)
    }
    
    
    func adjustAddEventButtonContsraints() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        self.addEventButton.snp.makeConstraints{make in
            make.bottom.equalTo(eventsListView.view.snp.top).offset(Constants.Offset.offsetMinus5)
            make.leading.equalTo(eventsListView.view)
            make.trailing.equalTo(eventsListView.view)
            make.height.equalTo(Constants.Size.size40)
        }
    }
}
