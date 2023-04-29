//
//  NewNotePresenter.swift
//  DairyApp
//
//  Created by sss on 28.04.2023.
//

import Foundation

protocol NewNotePresenterProtocol: AnyObject {
    var emotionalTag: [String] {get}
    var physicalTag: [String] {get}
    
    var selectedTagsEmotional: Set<String> {get set}
    var selectedTagsPhysical: Set<String> {get set}
    var temporaryModel: TemporaryViewModel {get}
    
    func textViewDidSelected(with text: String)
    func moodDidSeletEmotionalValue(with emotionalValue: Float)
    func moodDidSeletPhysicalValue(with physicalValue: Float)
    func photoDidSelect(photoData: Data?)
    func saveButtonDidTapped()
}

protocol NewNoteViewProtocol: AnyObject {
    
}

final class NewNotePresenter: NewNotePresenterProtocol {
    
    //MARK: - Property
    
    var temporaryModel: TemporaryViewModel

    var emotionalTag = ["#отдых", "#много работы", "#хобби", "#сериалы", "#вкусная еда", "#невкусная еда", "#общение", "#спорт", "#игры", "#выгорание"]
    var physicalTag = ["#головная боль", "#мало сна", "#достаточно сна", "#ранний подьем", "#поздний подьем", "#усталость", "#простуда", "#лекарства"]
    
    var selectedTagsEmotional = Set<String>()
    var selectedTagsPhysical = Set<String>()
    
    
    weak var view: NewNoteViewProtocol?
    let coreDataManager: CoreDataManager
    let fileManager: FileManagerForImage
    
    
    //MARK: - Init
    
    init(view: NewNoteViewProtocol, coreDataManager: CoreDataManager, fileManager: FileManagerForImage) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.fileManager = fileManager
        temporaryModel = TemporaryViewModel()
    }
    
    //MARK: - Method
    
    func textViewDidSelected(with text: String) {
        temporaryModel.text = text
    }
    
    func moodDidSeletEmotionalValue(with emotionalValue: Float) {
        temporaryModel.emotionalValue = emotionalValue
    }
    
    func moodDidSeletPhysicalValue(with physicalValue: Float) {
        temporaryModel.physicalValue = physicalValue
    }
    
    func photoDidSelect(photoData: Data?) {
        //temporaryModel.pathToSelectedPhoto = path
        guard let imagePath = fileManager.saveImage(imageData: photoData) else { return }
        temporaryModel.pathToSelectedPhoto = imagePath
    }
    
    func saveButtonDidTapped() {
        temporaryModel.tag = Array(selectedTagsEmotional.union(selectedTagsPhysical))
        print(temporaryModel)
        
        coreDataManager.createNewNote(text: temporaryModel.text,
                                      date: Date(),
                                      emotionalIndex: temporaryModel.emotionalValue,
                                      physicalIndex: temporaryModel.physicalValue,
                                      photoPath: temporaryModel.pathToSelectedPhoto,
                                      tagArray: temporaryModel.tag)
    }
}
