//
//  NewNoteViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

class NewNoteViewController: UIViewController {

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContentTableViewCell.self,
                           forCellReuseIdentifier: ContentTableViewCell.identifier)
        tableView.register(MoodTableViewCell.self,
                           forCellReuseIdentifier: MoodTableViewCell.identifier)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "background")
        return tableView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(named: "background")
        title = "Новая запись"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
       
    }
    
    //MARK: - Method
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    @objc private func save() {
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension NewNoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "ЗАПИСЬ"
        case 1:
            return "НАСТРОЕНИЕ"
        case 2:
            return "ДОБАВЬТЕ ФОТО"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell
            cell?.backgroundColor = UIColor(named: "background")
            return cell ?? UITableViewCell()
            
        case 1:
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MoodTableViewCell.identifier, for: indexPath) as? MoodTableViewCell
            
            return cell ?? UITableViewCell()
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 200
        case 2:
            return 200
        default:
            return 0
        }
    }
}
