//
//  MainTabBarController.swift
//  DairyApp
//
//  Created by sss on 21.11.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }
    
    private func setupTabs() {
        
        let dairyVC = DairyViewController()
        let newNoteVC = NewNoteViewController()
        let statisticsVC = StatisticViewController()
        let settingsVC = SettingsViewController()
        
        let firstNavVC = UINavigationController(rootViewController: dairyVC)
        let secondNavVC = UINavigationController(rootViewController: newNoteVC)
        let thirdVC = UINavigationController(rootViewController: statisticsVC)
        let forthVC = UINavigationController(rootViewController: settingsVC)
        
        let arrayVC = [dairyVC, newNoteVC, statisticsVC, settingsVC]
        let arrayTabBarImage = ["book", "plus.app", "chart.bar.xaxis", "gearshape"]
        for i in 0..<arrayVC.count {
            arrayVC[i].navigationItem.largeTitleDisplayMode = .automatic
            arrayVC[i].loadViewIfNeeded()
            arrayVC[i].tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: arrayTabBarImage[i]), tag: i)
        }
        let arrayOfNavVC = [firstNavVC, secondNavVC, thirdVC, forthVC]
        
        setViewControllers(
            arrayOfNavVC,
            animated: true
        )
        for controller in arrayOfNavVC {
            controller.navigationBar.prefersLargeTitles = true
        }
        
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = UIColor(named: "selectedItem")
        
    }
  
}
