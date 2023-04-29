//
//  PhotoTableViewCell.swift
//  DairyApp
//
//  Created by sss on 22.04.2023.
//

import UIKit
import AVFoundation
import Photos

protocol PhotoDidSelect: AnyObject {
    func photoDidSelect(photoData: Data?)
}

class PhotoTableViewCell: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    static let identifier = "PhotoTableViewCell"
    weak var delegate: PhotoDidSelect?
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var addPhotoButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("+", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor(named: "selected")
            button.layer.cornerRadius = 30
            button.clipsToBounds = true
            return button
        }()

    var selectedImage: UIImage?
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "smallBackground")
        contentView.addSubview(photoImageView)
        contentView.addSubview(addPhotoButton)
                
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    
            addPhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addPhotoButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 60),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
                
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = pickedImage
                photoImageView.image = pickedImage
                
                delegate?.photoDidSelect(photoData: pickedImage.pngData())
                /*
                 // Save image to file manager
                 let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                 let fileName = UUID().uuidString + ".png"
                 let fileURL = documentsDirectory.appendingPathComponent(fileName)
                 
                 delegate?.photoDidSelect(with: fileURL)
                 print(fileURL)
                 
                 if let data = pickedImage.pngData() {
                     do {
                         try data.write(to: fileURL)
                     } catch {
                         print("Error saving image to file manager: \(error.localizedDescription)")
                     }
                 }
                 */
                
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    
    
    @objc func addPhotoButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Выберите фото", message: nil, preferredStyle: .actionSheet)
        
        //1 action
        actionSheet.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { action in
            
           
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                DispatchQueue.main.async {
                    imagePickerController.sourceType = .camera
                    self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
                }
                
            } else {
                let alert = UIAlertController(title: "Камера не доступна", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }))
        
        //2 action
        actionSheet.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { action in
            if PHPhotoLibrary.authorizationStatus() == .authorized{
                
                DispatchQueue.main.async {
                    imagePickerController.sourceType = .photoLibrary
                    self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
                }
                
            }
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        imagePickerController.sourceType = .photoLibrary
                        self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
                    }
                }
            }
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }

}


