//
//  FileManagerForImage.swift
//  DairyApp
//
//  Created by sss on 22.04.2023.
//

import Foundation
import UIKit

struct FileManagerForImage {
    
    func saveImage(image: UIImage) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = UUID().uuidString + ".png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL)
                return fileName
            } catch {
                print("Error saving image: ", error)
                return nil
            }
        }
        return nil
    }

    func getImage(fileName: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: ", error)
            return nil
        }
    }
}