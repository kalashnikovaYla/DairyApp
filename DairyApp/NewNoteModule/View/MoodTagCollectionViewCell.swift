//
//  MoodTagCollectionViewCell.swift
//  DairyApp
//
//  Created by sss on 24.04.2023.
//

import UIKit

final class MoodTagCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property
    
    static let identifier = "MoodTagCollectionViewCell"
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
        
    //MARK: - Init
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil 
    }
}
