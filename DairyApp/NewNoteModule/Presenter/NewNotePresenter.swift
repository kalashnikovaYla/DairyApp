//
//  NewNotePresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol NewNotePresenterProtocol: AnyObject {
    
}

protocol NewNoteViewProtocol: AnyObject {
    
}

class NewNotePresenter: NewNotePresenterProtocol {
    
    weak var view: NewNoteViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    
    init(view: NewNoteViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
    }
}
