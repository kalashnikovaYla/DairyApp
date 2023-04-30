//
//  ModuleBuilder.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import UIKit

protocol BuilderProtocol {
    func createDairyModule() -> UIViewController
    func createNewNoteModule() -> UIViewController
    func createStatisticModule() -> UIViewController
    func createSettingsModule() -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    
    let dataObserver = DataObserver()
    
    func createDairyModule() -> UIViewController {
        let view = DairyViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = DairyPresenter(view: view,
                                       coreDataManager: coreDataManager,
                                       fileManager: fileManager,
                                       dataObserver: dataObserver)
        dataObserver.addObserver(observer: presenter)
        view.presenter = presenter
        return view
    }
    
    func createNewNoteModule() -> UIViewController {
        let view = NewNoteViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = NewNotePresenter(view: view,
                                         coreDataManager: coreDataManager,
                                         fileManager: fileManager,
                                         dataObserver: dataObserver)
        view.presenter = presenter
        return view
    }
    
    func createStatisticModule() -> UIViewController {
        let view = StatisticViewController()
        let coreDataManager = CoreDataManager()
        let fileManager = FileManagerForImage()
        let presenter = StatisticPresenter(view: view,
                                           coreDataManager: coreDataManager,
                                           fileManager: fileManager,
                                           dataObserver: dataObserver)
        view.presenter = presenter
        return view
    }
    
    func createSettingsModule() -> UIViewController {
        let view = SettingsViewController()
        return view
    }
}


class DataObserver {
    private var observers: [PresenterProtocol] = []
    func addObserver(observer: PresenterProtocol) {
        observers.append(observer)
    }
    func notifyObservers() {
        observers.forEach {
            $0.dataDidChange()
        }
    }
}

protocol PresenterProtocol {
    var dataObserver: DataObserver {get}
    func dataDidChange()
}
