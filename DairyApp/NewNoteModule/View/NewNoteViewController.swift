//
//  NewNoteViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

final class NewNoteViewController: UIViewController {

    //MARK: - Property
    
    var presenter: NewNotePresenterProtocol!
    
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
        
       
        
    }
    
    //MARK: - Method
    
    @objc private func cancel() {
        //
    }
    
    @objc private func save() {
        tableView.endEditing(true)
        presenter.saveButtonDidTapped()
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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ContentTableViewCell.identifier,
                for: indexPath
            ) as? ContentTableViewCell
            cell?.backgroundColor = UIColor(named: "background")
            cell?.delegate = self
            return cell ?? UITableViewCell()
            
        case 1:
        
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MoodTableViewCell.identifier,
                for: indexPath
            ) as? MoodTableViewCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        
        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TagTableViewCell.identifier,
                for: indexPath
            ) as? TagTableViewCell
            cell?.collectionView.delegate = self
            cell?.collectionView.dataSource = self
            return cell ?? UITableViewCell()
            
        case 3:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotoTableViewCell.identifier,
                for: indexPath
            ) as? PhotoTableViewCell
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
        presenter.textViewDidSelected(with: text)
    }
    
    func moodDidSeletEmotionalValue(with emotionalValue: Float) {
        presenter.moodDidSeletEmotionalValue(with: emotionalValue)
    }
    
    func moodDidSeletPhysicalValue(with physicalValue: Float) {
        presenter.moodDidSeletPhysicalValue(with: physicalValue)
    }
    /*
     func photoDidSelect(with path: URL?) {
         presenter.photoDidSelect(with: path)
     }
     */
   
    func photoDidSelect(photoData: Data?) {
        presenter.photoDidSelect(photoData: photoData)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension NewNoteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.emotionalTag.count
        case 1:
            return presenter.physicalTag.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodTagCollectionViewCell.identifier, for: indexPath) as! MoodTagCollectionViewCell
            cell.label.text = presenter.emotionalTag[indexPath.row]
            cell.backgroundColor = UIColor(named: "tagCell")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodTagCollectionViewCell.identifier, for: indexPath) as! MoodTagCollectionViewCell
            cell.label.text = presenter.physicalTag[indexPath.row]
            cell.backgroundColor = UIColor(named: "tagCell")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MoodTagCollectionViewCell
        guard let text = cell.label.text else {return}
        
        switch indexPath.section {
            
        case 0:
            if !presenter.selectedTagsEmotional.contains(text) {
                presenter.selectedTagsEmotional.insert(text)
                cell.backgroundColor = UIColor(named: "selected")
            } else {
                presenter.selectedTagsEmotional.remove(text)
                cell.backgroundColor = UIColor(named: "tagCell")
            }
            
        case 1:
            
            if !(presenter.selectedTagsPhysical.contains(text)) {
                presenter.selectedTagsPhysical.insert(text)
                cell.backgroundColor = UIColor(named: "selected")
            } else {
                presenter.selectedTagsPhysical.remove(text)
                cell.backgroundColor = UIColor(named: "tagCell")
            }
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
           
           let label = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.width - 16, height: headerView.frame.height))
           label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
           label.textColor = .label
           label.text = (indexPath.section == 0 ? "Настроение" : "Здоровье")
           headerView.addSubview(label)
           
           return headerView
    }
}

extension NewNoteViewController: NewNoteViewProtocol {
    
}
