//
//  ProfileViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 13/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI
import MobileCoreServices

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    var userID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        profileImageView.contentMode = .scaleToFill
        profileImageView.layer.cornerRadius = 125
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.userID = user?.uid
            self.emailLabel.text = user?.email
            self.getName { (fullName) in
                self.nameLabel.text = fullName
            }
            self.setImage()
        }
        

    }
    
    func setImage() {
        let storageReference = Storage.storage().reference()
        
        profileImageView.backgroundColor = .lightGray
        let placeHolder = UIImage(named: "")
        let userImageRef = storageReference.child("/photos").child(userID)
        
        userImageRef.downloadURL { (url, error) in
            if let error = error {
                print("error: ", error.localizedDescription)
            } else {
                self.profileImageView.sd_setImage(with: userImageRef, placeholderImage: placeHolder)
                print("imagen descargada")
            }
        }
        
    }
    
    func getName(completion: @escaping (_ fullName: String) -> Void) {
        let ref = Firestore.firestore().collection("users").document(self.userID)
        ref.getDocument { (snapshot, error) in
            let fullName = "\(snapshot?.get("name") ?? "") \(snapshot?.get("lastName") ?? "")"
            completion(fullName)
        }
    }

    @IBAction func uploadImageButtonTapped(_ sender: Any) {
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        photoPicker.mediaTypes = [kUTTypeImage as String]
        photoPicker.delegate = self
        
        present(photoPicker, animated: true, completion: nil)
    }
    
    func saveAndSetImage(_ imageData: Data) {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .red
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        
        
        
        let storageReference = Storage.storage().reference()
        let userImageRef = storageReference.child("/photos").child(userID)
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        userImageRef.putData(imageData, metadata: uploadMetadata) { (storageMetadata, error) in

            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            if let error = error {
                print("error ", error.localizedDescription)
            } else {

                self.profileImageView.image = UIImage(data: imageData)
            }
            
        }
        
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let optimizedImageData = selectedImage.jpegData(compressionQuality: 0.6) {
            saveAndSetImage(optimizedImageData)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
