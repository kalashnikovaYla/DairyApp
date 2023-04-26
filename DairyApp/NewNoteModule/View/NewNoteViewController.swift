//
//  NewNoteViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

class NewNoteViewController: UIViewController {

    var temporaryModel: TemporaryModel!
    
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContentTableViewCell.self,
                           forCellReuseIdentifier: ContentTableViewCell.identifier)
        tableView.register(MoodTableViewCell.self,
                           forCellReuseIdentifier: MoodTableViewCell.identifier)
        tableView.register(TagTableViewCell.self,
                           forCellReuseIdentifier: TagTableViewCell.identifier)
        tableView.register(PhotoTableViewCell.self,
                           forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.backgroundColor = UIColor(named: "background")
        return tableView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(named: "background")
        title = "Новая запись"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "button1")
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "button1")
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        temporaryModel = TemporaryModel()
        
    }
    
    //MARK: - Method
    
    @objc private func cancel() {
        //
    }
    
    @objc private func save() {
        tableView.endEditing(true)
        print(temporaryModel ?? "nil")
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
            return "ФАКТОРЫ"
        case 3:
            return "ДОБАВЬТЕ ФОТО"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell
            cell?.backgroundColor = UIColor(named: "background")
            cell?.delegate = self
            return cell ?? UITableViewCell()
            
        case 1:
        
            let cell = tableView.dequeueReusableCell(withIdentifier: MoodTableViewCell.identifier, for: indexPath) as? MoodTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.identifier, for: indexPath) as? TagTableViewCell
            
            return cell ?? UITableViewCell()
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell
            cell?.delegate = self
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 170
        case 2:
            return 400
        case 3:
            return 500
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.endEditing(true)
    }
   
}



//MARK: - TextViewDidSelected, MoodDidSelect, PhotoDidSelect

extension NewNoteViewController: TextViewDidSelected, MoodDidSelect, PhotoDidSelect {
   
    func textViewDidSelected(with text: String) {
        temporaryModel.text = text
    }
    
    func moodDidSeletEmotionalValue(with emotionalValue: Float) {
        temporaryModel.emotionalValue = emotionalValue
    }
    
    func moodDidSeletPhysicalValue(with physicalValue: Float) {
        temporaryModel.physicalValue = physicalValue
    }
    
    func photoDidSelect(with path: URL?) {
        temporaryModel.pathToSelectedPhoto = path
    }
    
    
}

struct TemporaryModel {
    var text: String = ""
    var emotionalValue: Float = 4
    var physicalValue: Float = 7
    var pathToSelectedPhoto: URL?
}
