//
//  CoreDataManager.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    ///Get all note
    public func getAllNote(completion: @escaping (Result<[Note], Error>) -> Void){
        do {
            let data = try context.fetch(Note.fetchRequest())
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
            let result = try context.fetch(fetchRequest) as? [Note]
            completion(.success(result ?? []))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    ///Save new note
    public func createNewNote(text: String?, date: Date, emotionalIndex: Float, physicalIndex: Float, photoPath: String?, tagArray: [String]?) {
        
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
            newNote.tagArray = tagArray as NSArray
        }
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
    ///Delete note
    public func deleteNote(note: Note) {
        context.delete(note)
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
    
}
