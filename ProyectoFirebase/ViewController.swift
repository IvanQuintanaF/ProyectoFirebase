//
//  ViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 06/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var getRef: Firestore!
    var ref: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getRef = Firestore.firestore()
    }

    @IBAction func createUserButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "",
            let pass = passwordTextField.text, pass != "",
            let name = nameTextField.text, name != "",
            let lastName = lastNameTextField.text, lastName != "" else {
            self.showAlert(message: "Something is missing")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let uid = user?.user.uid {
                self.storeUser(uid: uid, name: name, lastName: lastName)
                print("usuario creado", user?.user.uid ?? "usuario desconocido")
            }
        }
    }
    
    func storeUser(uid: String, name: String, lastName: String) {
        let data: [String: Any] = [
            "name": name,
            "lastName": lastName
        ]
        
        getRef.collection("users").document(uid).setData(data) { (error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
            } else {
                self.showAlert(message: "User created")
                self.cleanFields()
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        cleanFields()
    }
    
    func cleanFields(){
        nameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ok", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

