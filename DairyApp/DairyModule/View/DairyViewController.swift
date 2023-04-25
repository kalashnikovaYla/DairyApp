//
//  DairyViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import CoreData

struct WeekDay {
    let name: String
    var isSelected: Bool = false
}

var weekDays: [WeekDay] = [
    WeekDay(name: "ПН"),
    WeekDay(name: "BT"),
    WeekDay(name: "СР"),
    WeekDay(name: "ЧТ"),
    WeekDay(name: "ПТ"),
    WeekDay(name: "СВ"),
    WeekDay(name: "ВС")
]


final class DairyViewController: UIViewController {

    //MARK: - Property
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let width = (view.bounds.width - 4 * 8)/7
        layout.itemSize = CGSize(width: width, height: 40)
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeekDayCollectionViewCell.self,
                                    forCellWithReuseIdentifier: WeekDayCollectionViewCell.identifier)
       
        return collectionView
    }()
        
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor(named: "background")
        title = "Дневник"
        var date = Date()
        
        setupSubviews()
    }
        
    //MARK: - Method
    
    func setupSubviews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
              collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
              collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
              collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
              collectionView.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
}



//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension DairyViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeekDayCollectionViewCell.identifier,
            for: indexPath) as? WeekDayCollectionViewCell
        else {return UICollectionViewCell()}
        
        cell.backgroundColor = UIColor(named: "tagCell")
        cell.weekdayLabel.text = weekDays[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WeekDayCollectionViewCell
        else {return}
        
    }
}

