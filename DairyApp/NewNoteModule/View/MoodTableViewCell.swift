//
//  MoodTableViewCell.swift
//  DairyApp
//
//  Created by sss on 22.04.2023.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    static let identifier = "MoodTableViewCell"
    
    var emotionalValue: UILabel = {
        let label = UILabel()
        label.text = "Эмоциональное состояние"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var physicalValue: UILabel = {
        let label = UILabel()
        label.text = "Физическое состояние"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sliderEmotional: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var sliderPhysical: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(sliderEmotional)
        contentView.addSubview(sliderPhysical)
        contentView.addSubview(emotionalValue)
        contentView.addSubview(physicalValue)
        
        contentView.backgroundColor = UIColor(named: "background")
        
        NSLayoutConstraint.activate([
            emotionalValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            emotionalValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            sliderEmotional.topAnchor.constraint(equalTo: emotionalValue.bottomAnchor, constant: 20),
            sliderEmotional.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sliderEmotional.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            physicalValue.topAnchor.constraint(equalTo: sliderEmotional.bottomAnchor, constant: 30),
            physicalValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            sliderPhysical.topAnchor.constraint(equalTo: physicalValue.bottomAnchor, constant: 20),
            sliderPhysical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sliderPhysical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
