//
//  DairyPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol DiaryPresenterProtocol: AnyObject {
    var weekDays: [WeekDay] {get}
    var data: [NoteViewModel] {get}
    
    func cellBackground(index: Int) -> Bool
    func dateIsSelected(date: Date?)
    func showAllNoteButtonIsapped()
    func deleteButtonWasTapped(index: Int)
}

protocol DairyViewProtocol: AnyObject {
    func updateData()
    func dataIsNotExist() 
}

final class DiaryPresenter: DiaryPresenterProtocol, PresenterProtocol {
    
    //MARK: - Properties
    
    weak var view: DairyViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    var dataObserver: DataObserver
    
    var rawData: [Note] = []
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
    
    init(view: DairyViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage, dataObserver: DataObserver) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
        self.dataObserver = dataObserver
        getAllNote()
    }
    
    //MARK: - Method
    
    private func getAllNote() {
        coreDataManager.getAllNote { [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.rawData = data
                
                let newViewModels = createViewModels(data: data)
                self.data = newViewModels
                view?.updateData()
                
            case .failure(let error):
                view?.dataIsNotExist()
                print(error)
            }
        }
    }
    
    
    func cellBackground(index: Int) -> Bool {
        let today = Date()
        if calendar.component(.weekday, from: today) == index + 2 {
            return true
        } else {
            return false
        }
    }
    
    func dataDidChange() {
        getAllNote()
    }
    
    func showAllNoteButtonIsapped()  {
        getAllNote()
    }
    
    
    func dateIsSelected(date: Date?) {
        guard let date = date else {return}
        
        coreDataManager.searchDate(date: date) { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let data):
                if data.isEmpty {
                    view?.dataIsNotExist()
                } else {
                    let newViewModels = self.createViewModels(data: data)
                    self.data = newViewModels
                    self.view?.updateData()
                }
                
            case .failure(let error):
                view?.dataIsNotExist()
                print(error)
            }
        }
    }
    
    private func createViewModels(data: [Note]) -> [NoteViewModel] {
        let newViewModels = data.map { note in
        
            let image = self.fileManager.getImage(fileName: note.photoPath)
            let index = Int(note.emotionalIndex + note.physicalIndex)
            var emoji = ""
            
            switch index {
            case 0...4:
                emoji = "🤯"
            case 5...8:
                emoji = "😰"
            case 9...11:
                emoji =  "😐"
            case 12...14:
                emoji =  "😇"
            case 15...18:
                emoji =  "🎊"
            case 19...20:
                emoji =  "🏆"
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
        return newViewModels
    }
    
    func deleteButtonWasTapped(index: Int) {
        data.remove(at: index)
        coreDataManager.deleteNote(note: rawData[index])
        
    }
}
