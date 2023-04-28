//
//  StatisticViewController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

class StatisticViewController: UIViewController {

    var presenter: StatisticPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Статистика"
        view.backgroundColor = UIColor(named: "background")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension StatisticViewController: StatisticViewProtocol {
    
}
