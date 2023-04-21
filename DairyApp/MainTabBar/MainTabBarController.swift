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

        generateTabBar()
        setTabBarAppearence()
    }
    

    private func generateTabBar() {
        viewControllers = [
            
            
            generateVC(viewController: DairyViewController(),
                       image: UIImage(systemName: "book")),
            
            generateVC(viewController: NewNoteViewController(),
                       image: UIImage(systemName: "plus.app")),
            
            generateVC(viewController: StatisticViewController(),
                       image: UIImage(systemName: "chart.bar.xaxis")),
            
            generateVC(viewController: SettingsViewController(),
                       image: UIImage(systemName: "gearshape"))
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearence() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height/2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width/5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor(named: "selectedItem")
    }
}
