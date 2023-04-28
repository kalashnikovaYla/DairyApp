//
//  DairyViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import CoreData


struct Model {
    var text: String
    var index: Int
    var tag: [String]
    var date = Date() 
    var image: UIImage?
}


final class DairyViewController: UIViewController {

    //MARK: - Property
    
    let models = [Model(
        text: """
SWIFT – это система, которую используют банки для обмена платежами между странами. Она заменяет другие каналы связи и помогает передавать конфиденциальные сообщения с информацией о денежных переводах. Разбираемся, как устроена система SWIFT.
""",
        index: 0,
        tag: ["плохой сон", "стресс", "выгорание"],
        image: UIImage(named: "im2"))]
    
    
    
    let calendar = Calendar.current
    
    var weekDays: [WeekDay] = [
        WeekDay(name: "ПН"),
        WeekDay(name: "BT"),
        WeekDay(name: "СР"),
        WeekDay(name: "ЧТ"),
        WeekDay(name: "ПТ"),
        WeekDay(name: "СВ"),
        WeekDay(name: "ВС")
    ]

    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    var presenter: DairyPresenterProtocol!
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "background")
        tableView.register(DairyTableViewCell.self, forCellReuseIdentifier: DairyTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor(named: "background")
        title = "Дневник"
        
        setupSubviews()
        
    }
        
    //MARK: - Method
    
    func setupSubviews() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
            
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 44),
              
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        let today = Date()
        if calendar.component(.weekday, from: today) == indexPath.row + 2 {
            cell.backgroundColor = UIColor(named: "selected")
        } else {
            cell.backgroundColor = UIColor(named: "tagCell")
        }
        
        cell.weekdayLabel.text = weekDays[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let today = Date()
        let currentWeekday = indexPath.row + 2
        if let selectedDate = calendar.nextDate(after: today, matching: .init(weekday: currentWeekday), matchingPolicy: .strict) {
            print(selectedDate)
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension DairyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DairyTableViewCell.identifier, for: indexPath) as? DairyTableViewCell else {return UITableViewCell()}
        cell.layer.cornerRadius = 18
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "button1")?.cgColor
        cell.clipsToBounds = true
        
        cell.dateLabel.text = dateFormatter.string(from: Date())
        cell.contentLabel.text = models[0].text
        cell.smileLabel.text = Emoji(rawValue: models[0].index)?.emoji
        cell.myImageView.image = models[0].image
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if models[indexPath.row].image != nil {
            return 550
        } else {
            return 300
        }
    }
}


extension DairyViewController: DairyViewProtocol {
    
}
