//
//  WeekDayCollectionViewCell.swift
//  DairyApp
//
//  Created by sss on 25.04.2023.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeekDayCollectionViewCell"
    
    let weekdayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "textColor")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(weekdayLabel)
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        weekdayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        weekdayLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        weekdayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
