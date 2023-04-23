//
//  ContentTableViewCell.swift
//  DairyApp
//
//  Created by sss on 22.04.2023.
//

import UIKit
 
protocol TextViewDidSelected: AnyObject {
    func textViewDidSelected(with text: String)
}


final class ContentTableViewCell: UITableViewCell {
    
    static let identifier = "ContentTableViewCell"
    
    weak var delegate: TextViewDidSelected?
    
    
    var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 20
        textView.backgroundColor = UIColor(named: "background")
        textView.font = UIFont.systemFont(ofSize: 17)
        
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textView)
        
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ContentTableViewCell: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        delegate?.textViewDidSelected(with: textView.text)
        return true
    }
    
}

