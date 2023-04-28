//
//  DairyPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol DairyPresenterProtocol: AnyObject {
    
}

protocol DairyViewProtocol: AnyObject {
    
}

class DairyPresenter: DairyPresenterProtocol {
    
    weak var view: DairyViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    
    init(view: DairyViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
    }
}
