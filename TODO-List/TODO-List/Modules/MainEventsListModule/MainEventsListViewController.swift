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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsListView = MainEventsListPageViewController()
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

        setDataSourceAndDelegates()
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func setUpConstraints() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        eventsListView.view.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(Constants.Offset.offset225)
            make.left.equalToSuperview().offset(Constants.Offset.offset10)
            make.right.equalToSuperview().offset(Constants.Offset.offsetMinus10)
            make.bottom.equalToSuperview().offset(Constants.Offset.offsetMinus90)
        }
    }
    
    func setDataSourceAndDelegates() {
        guard let eventsListView = eventsListView as? UIPageViewController else {return}
        eventsListView.dataSource = presenter
        eventsListView.delegate = presenter
    }
}
