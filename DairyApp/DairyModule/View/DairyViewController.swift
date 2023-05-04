//
//  DairyViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import CoreData

final class DairyViewController: UIViewController {

    //MARK: - Property
    
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
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Упс! Записи отсутствуют"
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.isHidden = true
        return label
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  UIColor(named: "background")
        title = "Дневник"
        
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(openCalendarView)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "button1")
        setupSubviews()
    }
    
    
    
    //MARK: - Method
    
    func setupSubviews() {
        view.addSubview(label)
        view.addSubview(collectionView)
        view.addSubview(tableView)
            
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
    
    @objc private func openCalendarView() {
        let calendarVC = SearchNoteViewController(presenter: presenter)
        calendarVC.sheetPresentationController?.detents = [.medium()]
        calendarVC.sheetPresentationController?.prefersGrabberVisible = true
        present(calendarVC, animated: true)
    }
}



//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

extension DairyViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.weekDays.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeekDayCollectionViewCell.identifier,
            for: indexPath) as? WeekDayCollectionViewCell
        else {return UICollectionViewCell()}
        
        let colorString = presenter.cellBackground(index: indexPath.row) ? "selected": "tagCell"
        
        cell.backgroundColor = UIColor(named: colorString)
        
        cell.weekdayLabel.text = presenter.weekDays[indexPath.row].name
        return cell
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension DairyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DairyTableViewCell.identifier,
            for: indexPath) as? DairyTableViewCell
        else {return UITableViewCell()}
        
        cell.layer.cornerRadius = 18
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(named: "button1")?.cgColor
        cell.clipsToBounds = true
        
        cell.dateLabel.text = presenter?.data[indexPath.row].date
        cell.contentLabel.text = presenter?.data[indexPath.row].text
        cell.smileLabel.text = presenter?.data[indexPath.row].smile
        if let image = presenter?.data[indexPath.row].image {
            cell.myImageView.image = image
        }
        cell.tags = presenter?.data[indexPath.row].tag
        cell.collectionView.reloadData()
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if presenter?.data[indexPath.row].image != nil {
            return 550
        } else if presenter?.data[indexPath.row].text?.count ?? 1 <= 10 {
            return 100
        } else {
            return 300
        }
    }
}

//MARK: - DairyViewProtocol

extension DairyViewController: DairyViewProtocol {
    
    func updateData() {
        tableView.isHidden = false
        label.isHidden = true
        tableView.reloadData()
    }
    
    func dataIsNotExist() {
        tableView.isHidden = true
        label.isHidden = false
    }
}


