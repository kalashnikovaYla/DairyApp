//
//  SettingsViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

final class SettingsViewController: UIViewController {

    let settings = ["Уведомления", "Безопасность", "О приложении"]
    let identifier = "cell"
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "background")
        return tableView
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Настройки"
        view.backgroundColor = UIColor(named: "background")
        tableView.backgroundColor = UIColor(named: "background")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 10
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = settings[indexPath.row]
        configuration.textProperties.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        configuration.textProperties.color = .label
        
        var imageName = ""
        switch indexPath.row {
        case 0:
            imageName = "bell.and.waves.left.and.right"
        case 1:
            imageName = "shield.righthalf.filled"
        case 2:
            imageName = "list.bullet.rectangle.portrait"
        default:
            break
        }
        let image = UIImage(systemName: imageName)?.withTintColor(UIColor(named: "button1") ?? UIColor.label, renderingMode: .alwaysOriginal)
        configuration.image = image
    
        cell.contentConfiguration = configuration
        cell.backgroundColor = UIColor(named: "smallBackground")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("")
            
        case 1:
            let biometricVC = BiometricViewController()
            biometricVC.sheetPresentationController?.detents = [.medium()]
            biometricVC.sheetPresentationController?.prefersGrabberVisible = true
            present(biometricVC, animated: true)
        case 2:
            print("")
            
        default:
            break
        }
    
    }
    
    
}
