//
//  DairyTableViewCell.swift
//  DairyApp
//
//  Created by sss on 26.04.2023.
//

import UIKit


class DairyTableViewCell: UITableViewCell {

    //MARK: - Property
    
    static let identifier = "DairyTableViewCell"
    
    var tags: [String]?
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let smileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    var collectionView: UICollectionView!
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = UIColor(named: "background")
        
        createCollectionView()
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(smileLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(myImageView)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            smileLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            smileLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.heightAnchor.constraint(equalToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            
            myImageView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 230),
            myImageView.widthAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
        smileLabel.text = nil
        dateLabel.text = nil
        contentLabel.text = nil 
    }
    
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 120, height: 30)
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.register(MoodTagCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoodTagCollectionViewCell.identifier)
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension DairyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoodTagCollectionViewCell.identifier, for: indexPath) as! MoodTagCollectionViewCell
        
        cell.label.text = tags?[indexPath.row] ?? "" 
        cell.backgroundColor = UIColor(named: "tagCell")
        return cell
    }
    
}


