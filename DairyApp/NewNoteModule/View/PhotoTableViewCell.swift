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

final class PhotoTableViewCell: UITableViewCell {

    //MARK: - Property
    
    static let identifier = "PhotoTableViewCell"
    weak var delegate: PhotoDidSelect?
    
    var photoImageView: UIImageView = {
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
        
        settingsView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Methods

    func settingsView() {
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
    
    
    @objc private func addPhotoButtonTapped() {
        
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
                    self.window?.rootViewController?.present(imagePickerController, animated: true)
                }
            }
            
            if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        imagePickerController.sourceType = .photoLibrary
                        self.window?.rootViewController?.present(imagePickerController, animated: true)
                    }
                }
            }
        
        }))
        actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }

    override func prepareForReuse() {
        photoImageView.image = nil 
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension PhotoTableViewCell: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                selectedImage = pickedImage
                photoImageView.image = pickedImage.fixOrientation()
        
                delegate?.photoDidSelect(photoData: pickedImage.jpegData(compressionQuality: 0.8))
            }
            picker.dismiss(animated: true, completion: nil)
        }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        var transform: CGAffineTransform = CGAffineTransform.identity

        switch self.imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi / 2))
        default:
            break
        }

        switch self.imageOrientation {
        case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }

        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                        bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                        space: self.cgImage!.colorSpace!,
                                        bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!

        ctx.concatenate(transform)

        switch self.imageOrientation {
        case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            break
        }

        let cgImage: CGImage = ctx.makeImage()!
        let fixedImage: UIImage = UIImage(cgImage: cgImage)

        return fixedImage
    }
}
