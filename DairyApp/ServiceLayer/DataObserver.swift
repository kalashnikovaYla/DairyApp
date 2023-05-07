//
//  DataObserver.swift
//  DairyApp
//
//  Created by sss on 07.05.2023.
//

import Foundation

protocol PresenterProtocol {
    var dataObserver: DataObserver {get}
    func dataDidChange()
}


final class DataObserver {
    
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

