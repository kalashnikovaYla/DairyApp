//
//  StatisticPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol StatisticPresenterProtocol: AnyObject {
    
}

protocol StatisticViewProtocol: AnyObject {
    
}

class StatisticPresenter: StatisticPresenterProtocol {
    
    weak var view: StatisticViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    
    init(view: StatisticViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
    }
}
