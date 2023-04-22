//
//  DairyViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit
import CoreData

final class DairyViewController: UIViewController {

    var model = [Note]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DairyTableViewCell.self, forCellReuseIdentifier: DairyTableViewCell.identifier)
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Дневник"
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension DairyViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DairyTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    
}
