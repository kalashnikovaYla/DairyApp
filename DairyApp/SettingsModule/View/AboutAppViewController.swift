//
//  AboutAppViewController.swift
//  DairyApp
//
//  Created by sss on 07.05.2023.
//

import UIKit

final class AboutAppViewController: UIViewController {

    let content = ["Приложение Diary - это дневник, в котором ты можешь записывать все, что происходило с тобой за день",
                   "Ты можешь ставить теги, оценивать свое эмоциональное и физическое состояние, прикреплять фото",
                   "Также ты можешь осуществлять поиск своих записей от определенной даты",
                   "Diary будет вести статистику твоего самочувтвия и ты сможешь отслеживать динамику своего настроения",
                   "Ты можешь защитить свои записи от посторонних лиц, включив в настройках возможность входа только через Face ID"]
    
    let contentEmoji = ["📓", "🧘", "🔍", "📊", "🔒"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let width = view.bounds.width - 15
        layout.itemSize = CGSize(width: width, height: width - 30)
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "smallBackground")
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(AboutCollectionViewCell.self,
                                    forCellWithReuseIdentifier: AboutCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = UIColor(named: "smallBackground")
    }

}

//MARK: - UICollectionViewDataSource

extension AboutAppViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AboutCollectionViewCell.identifier,
            for: indexPath) as? AboutCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.label.text = content[indexPath.row]
        cell.labelEmoji.text = contentEmoji[indexPath.row]
        return cell
    }
}
 
