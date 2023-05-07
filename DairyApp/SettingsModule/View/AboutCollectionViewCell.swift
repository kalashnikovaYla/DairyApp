//
//  AboutCollectionViewCell.swift
//  DairyApp
//
//  Created by sss on 07.05.2023.
//

import UIKit

final class AboutCollectionViewCell: UICollectionViewCell {
   
    
    //MARK: - Property
    
    static let identifier = "AboutCollectionViewCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 23, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var labelEmoji: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        contentView.addSubview(label)
        contentView.addSubview(labelEmoji)
        contentView.backgroundColor = UIColor(named: "ondoardBackground")
        contentView.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            labelEmoji.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            labelEmoji.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        labelEmoji.text = nil
    }
}
