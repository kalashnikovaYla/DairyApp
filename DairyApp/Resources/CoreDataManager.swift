//
//  CoreDataManager.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    ///Get all note
    public func getAllNote(completion: @escaping (Result<[Note], Error>) -> Void){
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            guard let data = try context?.fetch(fetchRequest) else {
                print("error")
                return 
            }
            completion(.success(data))
        } catch let error {
            completion(.failure(error))
            
        }
    }
    
    ///Search note use date
    public func searchDate(date: Date, completion: @escaping (Result<[Note], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let predicate = NSPredicate(format: "date = %@", date as NSDate)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context?.fetch(fetchRequest) as? [Note]
            completion(.success(result ?? []))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    ///Search today note
    public func searchTodayNote(completion: @escaping (Result<[Note], Error>) -> Void) {
        
        let startDate = Calendar.current.startOfDay(for: Date())
        guard let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) as? NSDate else {return}
        
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        
        
        do {
            let result = try context?.fetch(fetchRequest) as? [Note]
            completion(.success(result ?? []))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    ///Search weekday note
    public func searchWeekdayNote(completion: @escaping (Result<[Note], Error>) -> Void) {
        
        guard let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) as? NSDate else {return}
        let endDate = Date()
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        
        do {
            let result = try context?.fetch(fetchRequest) as? [Note]
            completion(.success(result ?? []))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    ///Search month note
    public func searchMonthNote(completion: @escaping (Result<[Note], Error>) -> Void) {
        
        guard let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) as? NSDate else {return}
        let endDate = Date()
        
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        
        do {
            let result = try context?.fetch(fetchRequest) as? [Note]
            completion(.success(result ?? []))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    ///Save new note
    public func createNewNote(text: String?, date: Date, emotionalIndex: Float, physicalIndex: Float, photoPath: String?, tagArray: [String]?) {
        guard let context = context else {
            print("error")
            return
        }
        let newNote = Note(context: context)
        if let text = text {
            newNote.text = text
        }
        newNote.date = date
        newNote.emotionalIndex = emotionalIndex
        newNote.physicalIndex = physicalIndex
        if let photoPath = photoPath {
            newNote.photoPath = photoPath
        }
        if let tagArray = tagArray {
            newNote.tagArray = try? NSKeyedArchiver.archivedData(
                withRootObject: tagArray,
                requiringSecureCoding: false
            )
        }
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    ///Delete note
    public func deleteNote(note: Note) {
        guard let context = context else {
            print("error")
            return
        }
        context.delete(note)
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
}
