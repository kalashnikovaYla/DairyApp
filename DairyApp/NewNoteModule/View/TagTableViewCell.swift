//
//  TagTableViewCell.swift
//  DairyApp
//
//  Created by sss on 24.04.2023.
//

import UIKit

class TagTableViewCell: UITableViewCell {
    
    static let identifier = "TagTableViewCell"
    private let collectionView: UICollectionView
    
    let emotionalTag = ["#отдых", "#много работы", "#хобби", "#сериалы", "#вкусная еда", "#невкусная еда", "#общение", "#спорт", "#игры", "№выгорание"]
    let physicalTag = ["#головная боль", "#мало сна", "#достаточно сна", "#ранний подьем", "#поздний подьем", "#усталость", "#простуда", "#лекарства"]
    
    var selectedTagsEmotional = Set<String>()
    var selectedTagsPhysical = Set<String>()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 135, height: 30)
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoodTagCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoodTagCollectionViewCell.identifier)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerView")
        
           // add collectionView to cell's contentView
           contentView.addSubview(collectionView)
        
           collectionView.translatesAutoresizingMaskIntoConstraints = false
        
           NSLayoutConstraint.activate([
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
           ])
       }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TagTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return emotionalTag.count
        case 1:
            return physicalTag.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodTagCollectionViewCell.identifier, for: indexPath) as! MoodTagCollectionViewCell
            cell.label.text = emotionalTag[indexPath.row]
            cell.backgroundColor = UIColor(named: "tagCell")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodTagCollectionViewCell.identifier, for: indexPath) as! MoodTagCollectionViewCell
            cell.label.text = physicalTag[indexPath.row]
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
            if !selectedTagsEmotional.contains(text) {
                selectedTagsEmotional.insert(text)
                cell.backgroundColor = UIColor(named: "selected")
            } else {
                selectedTagsEmotional.remove(text)
                cell.backgroundColor = UIColor(named: "tagCell")
            }
            
        case 1:
            
            if !selectedTagsPhysical.contains(text) {
                selectedTagsPhysical.insert(text)
                cell.backgroundColor = UIColor(named: "selected")
            } else {
                selectedTagsPhysical.remove(text)
                cell.backgroundColor = UIColor(named: "tagCell")
            }
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
           
           // Configure header view
           //headerView.backgroundColor = .white
           let label = UILabel(frame: CGRect(x: 16, y: 0, width: headerView.frame.width - 16, height: headerView.frame.height))
           label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
           label.textColor = .label
           label.text = (indexPath.section == 0 ? "Настроение" : "Здоровье")
           headerView.addSubview(label)
           
           return headerView
    }
}
