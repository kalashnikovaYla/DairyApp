//
//  DairyPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol DairyPresenterProtocol: AnyObject {
    var weekDays: [WeekDay] {get}
    var data: [NoteViewModel] {get}
    func viewDidAppear()
    func cellBackground(index: Int) -> Bool 
}

protocol DairyViewProtocol: AnyObject {
    func updateData()
    func dataIsNotExist() 
}

final class DairyPresenter: DairyPresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: DairyViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    var data: [NoteViewModel] = []
    
    var weekDays: [WeekDay] = [
        WeekDay(name: "ПН"),
        WeekDay(name: "BT"),
        WeekDay(name: "СР"),
        WeekDay(name: "ЧТ"),
        WeekDay(name: "ПТ"),
        WeekDay(name: "СБ"),
        WeekDay(name: "ВС")
    ]

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    var calendar = Calendar.current
    
    //MARK: - Init
    
    init(view: DairyViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
        
        getAllNote()
    }
    
    private func getAllNote() {
        coreDataManager.getAllNote { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let data):
                let newViewModels = data.map { note in
                    
                   
                    let image = self.fileManager.getImage(fileName: note.photoPath)
                    let index = Int(note.emotionalIndex + note.physicalIndex)
                    var emoji = ""
                    
                    switch index {
                    case 0...4:
                        emoji = "😞"
                    case 5...8:
                        emoji = "😔"
                    case 9...11:
                        emoji =  "😐"
                    case 12...14:
                        emoji =  "🙂"
                    case 15...18:
                        emoji =  "😊"
                    case 19...20:
                        emoji =  "😃"
                    default:
                        emoji = ""
                    }
                
                    var tag: [String]? = []
                    if let tagArray = note.tagArray {
                        tag = try? NSKeyedUnarchiver.unarchiveObject(with: tagArray) as? [String]
                    }
                    
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
                view?.updateData()
                
            case .failure(let error):
                view?.dataIsNotExist()
                print(error)
            }
        }
    }
    
    public func viewDidAppear() {
        getAllNote()
    }
    
    
    func cellBackground(index: Int) -> Bool {
        let today = Date()
        if calendar.component(.weekday, from: today) == index + 2 {
            return true
        } else {
            return false
        }
    }
}
