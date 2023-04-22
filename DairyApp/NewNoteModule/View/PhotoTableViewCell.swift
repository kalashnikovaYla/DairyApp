//
//  PhotoTableViewCell.swift
//  DairyApp
//
//  Created by sss on 22.04.2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    static let identifier = "PhotoTableViewCell"
    
    
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
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            return button
        }()

    var selectedImage: UIImage?
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(addPhotoButton)
                
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                    
            addPhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addPhotoButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addPhotoButton.widthAnchor.constraint(equalToConstant: 40),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
                
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    @objc func addButtonTapped() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
            
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                imagePickerController.sourceType = .camera
                self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
            
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            imagePickerController.sourceType = .photoLibrary
            self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
            
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = pickedImage
                photoImageView.image = pickedImage
                
                // Save image to file manager
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = UUID().uuidString + ".png"
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                if let data = pickedImage.pngData() {
                    do {
                        try data.write(to: fileURL)
                    } catch {
                        print("Error saving image to file manager: \(error.localizedDescription)")
                    }
                }
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
    
    
    @objc func addPhotoButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Выберите фото", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Сделать фото", style: .default, handler: { action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Камера не доступна", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { action in
            imagePickerController.sourceType = .photoLibrary
            self.window?.rootViewController?.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }

}

