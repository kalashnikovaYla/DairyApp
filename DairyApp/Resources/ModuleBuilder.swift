//
//  ModuleBuilder.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import UIKit

protocol BuilderProtocol {
    static func createDairyModule() -> UIViewController
    static func createNewNoteModule() -> UIViewController
    static func createStatisticModule() -> UIViewController
    static func createSettingsModule() -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    
    static func createDairyModule() -> UIViewController {
        let view = DairyViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = DairyPresenter(view: view,
                                       coreDataManager: coreDataManager,
                                       fileManager: fileManager)
        view.presenter = presenter
        return view
    }
    
    static func createNewNoteModule() -> UIViewController {
        let view = NewNoteViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = NewNotePresenter(view: view,
                                       coreDataManager: coreDataManager,
                                       fileManager: fileManager)
        view.presenter = presenter
        return view
    }
    
    static func createStatisticModule() -> UIViewController {
        let view = StatisticViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = StatisticPresenter(view: view,
                                       coreDataManager: coreDataManager,
                                       fileManager: fileManager)
        view.presenter = presenter
        return view
    }
    
    static func createSettingsModule() -> UIViewController {
        let view = SettingsViewController()
        return view
    }
}
