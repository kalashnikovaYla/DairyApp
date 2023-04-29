//
//  DairyPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol DairyPresenterProtocol: AnyObject {
    var weekDays: [WeekDay] {get}
    var data: [NoteViewModel]? {get}
}

protocol DairyViewProtocol: AnyObject {
    
}

final class DairyPresenter: DairyPresenterProtocol {
    
    weak var view: DairyViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    var data: [NoteViewModel]?
    
    var weekDays: [WeekDay] = [
        WeekDay(name: "ПН"),
        WeekDay(name: "BT"),
        WeekDay(name: "СР"),
        WeekDay(name: "ЧТ"),
        WeekDay(name: "ПТ"),
        WeekDay(name: "СВ"),
        WeekDay(name: "ВС")
    ]

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    init(view: DairyViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
        
        getAllNote()
    }
    
    public func getAllNote() {
        coreDataManager.getAllNote { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let data):
                let newViewModels = data.map { note in
                    
                   
                    let image = self.fileManager.getImage(fileName: note.photoPath)
                    let index = note.emotionalIndex + note.physicalIndex
                    let emoji = Emoji(rawValue: index)?.emoji ?? ""
                    let tag = note.tagArray as? [String]
                    var dateString = ""
                    if let date = note.date {
                        dateString = self.dateFormatter.string(from: date)
                    }
                    return NoteViewModel(text: note.text,
                                         date: dateString,
                                         smile: emoji,
                                         image: image,
                                         tag: tag ?? [])
                }
                self.data = newViewModels
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
