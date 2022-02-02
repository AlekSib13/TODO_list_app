//
//  CalendarViewController.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 31.01.2022.
//

import Foundation
import UIKit
import SnapKit

class CalendarViewController: UIViewController, CalendarViewControllerProtocol {
    
    var presenter: CalendarPresenterProtocol?
    
    
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = Constants.Size.size10
        backgroundView.layer.borderWidth = Constants.Size.size1
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.backgroundColor = Constants.Colour.sandYellow
        return backgroundView
    }()
    
    let calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendarCollectionView.isScrollEnabled = false
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        calendarCollectionView.backgroundColor = Constants.Colour.lightYellow
        calendarCollectionView.layer.cornerRadius = Constants.Size.size10
        calendarCollectionView.layer.borderWidth = Constants.Size.size1
        calendarCollectionView.layer.borderColor = Constants.Colour.brickBrownLighter.cgColor
        
        return calendarCollectionView
    }()
    
    let calendar = Calendar(identifier: .gregorian)
    
    //MARK: TODO - change transition style - it should transition vertically from up to down from calendar button
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .pageSheet
        self.modalTransitionStyle = .coverVertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpConstraints()
    }
    
    
    func configureView() {
        view.backgroundColor = .none
        view.addSubview(backgroundView)
        backgroundView.addSubview(calendarCollectionView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(aroundCalendarTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setUpConstraints() {
        backgroundView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(Constants.Offset.offset25)
            make.centerY.equalToSuperview().offset(90)
            make.height.equalTo(270)
        }
        
        calendarCollectionView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(Constants.Offset.offset5)
            make.top.equalToSuperview().inset(Constants.Offset.offset30)
            make.bottom.equalToSuperview().inset(Constants.Offset.offset5)
        }
    }
    
    @objc func aroundCalendarTapped() {
        print("calendar is dismissed")
        presenter?.dismissCalendar()
    }
    
    
}
