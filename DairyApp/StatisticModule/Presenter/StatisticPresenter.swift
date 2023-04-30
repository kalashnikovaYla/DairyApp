//
//  StatisticPresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol StatisticPresenterProtocol: AnyObject {
    var emotionalIndexValues: [Double] {get set}
    var physicalIndexValues: [Double] {get set}
    func loadingView(withIndex index: Int)
}

protocol StatisticViewProtocol: AnyObject {
    func settingsCharts()
}

final class StatisticPresenter: StatisticPresenterProtocol, PresenterProtocol {
    
    var dataObserver: DataObserver
    
    func dataDidChange() {
        loadingView(withIndex: 0)
    }
    
    
    //MARK: - Property
    
    weak var view: StatisticViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    var emotionalIndexValues = [Double]()
    var physicalIndexValues = [Double]()
    
    //MARK: - Init
    
    init(view: StatisticViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage, dataObserver: DataObserver) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
        self.dataObserver = dataObserver
    }
    
    
    func loadingView(withIndex index: Int) {
        switch index {
        case 0:
            coreDataManager.searchTodayNote { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let notes):
                    
                    self.emotionalIndexValues = notes.compactMap {
                        Double($0.emotionalIndex).rounded()
                    }
                    self.physicalIndexValues = notes.compactMap {
                        Double($0.physicalIndex).rounded()
                    }
                    
                    view?.settingsCharts()
                    
                case .failure(let error):
                    print(error)
                }
            }
            
        case 1:
            coreDataManager.searchWeekdayNote { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let notes):
                    let averageArrays = self.averageValuesByDay(notes: notes)
                    self.emotionalIndexValues = averageArrays.emotionalIndex.map{ Double($0).rounded()}
                    self.physicalIndexValues = averageArrays.physicalIndex.map{ Double($0).rounded()}
                    
                    view?.settingsCharts()
                case .failure(let error):
                    print(error)
                }
            }
        case 2:
            coreDataManager.searchMonthNote { [weak self] result in
                guard let self = self else {return}
                
                switch result {
                case .success(let notes):
                    
                    let averageArrays = self.averageValuesByDay(notes: notes)
                    self.emotionalIndexValues = averageArrays.emotionalIndex.map{ Double($0).rounded()}
                    self.physicalIndexValues = averageArrays.physicalIndex.map{ Double($0).rounded()}
                    
                    view?.settingsCharts()
                    
                case .failure(let error):
                    print(error)
                }
            }
        default:
            break
        }
    }
    
    func averageValuesByDay(notes: [Note]) -> (emotionalIndex: [Float], physicalIndex: [Float]) {
        let calendar = Calendar.current
        
        let groups = Dictionary(grouping: notes) { note -> Date in
            
            let components = calendar.dateComponents([.year, .month, .day], from: note.date ?? Date())
            return calendar.date(from: components)!
        }
        let emotionalIndex = groups.mapValues { notes -> Float in
            let values = notes.map { $0.emotionalIndex }
            return values.reduce(0, +) / Float(values.count)
        }.values.sorted()
        let physicalIndex = groups.mapValues { notes -> Float in
            let values = notes.map { $0.physicalIndex }
            return values.reduce(0, +) / Float(values.count)
        }.values.sorted()
        return (emotionalIndex, physicalIndex)
    }
}
