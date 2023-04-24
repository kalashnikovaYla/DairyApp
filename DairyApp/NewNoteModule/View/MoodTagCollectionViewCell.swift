//
//  MoodTagCollectionViewCell.swift
//  DairyApp
//
//  Created by sss on 24.04.2023.
//

import UIKit

class MoodTagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MoodTagCollectionViewCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        contentView.addSubview(label)
        layer.cornerRadius = 15
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
