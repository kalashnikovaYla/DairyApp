//
//  BiometricViewController.swift
//  DairyApp
//
//  Created by sss on 04.05.2023.
//

import UIKit

final class BiometricViewController: UIViewController {

    //MARK: - Property
    
    var titleText = "Face ID"
    var biometric: Bool!
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Использование Face ID"
        label.textColor = .label
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Вы можете защитить ваш дневник от постронних лиц, добавив возможность входа в приложение через Face ID"
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "shield.righthalf.filled")
        imageView.tintColor = UIColor(named: "selected")
        imageView.image = image
        return imageView
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "selected")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        biometric = UserDefaults.standard.bool(forKey: "useBiometricAuthentication")
        button.setTitle(!biometric ? "Использовать Face ID" : "Не использовать Face ID", for: .normal)
        settingsSubviews()
    }
    
    //MARK: - Methods
    
    private func settingsSubviews() {
        view.backgroundColor = UIColor(named: "background")
        
        button.addTarget(self, action: #selector(biometricBattonWasTapped), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            button.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

    @objc private func biometricBattonWasTapped() {
        UserDefaults.standard.set(!biometric, forKey: "useBiometricAuthentication")
        dismiss(animated: true)
    }

    

}
