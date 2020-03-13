//
//  LoginViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 07/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firestore.firestore()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, email != "",
            let pass = passwordTextField.text, pass != "" else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("usuario Autenticado")
                let welcomeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController
                self.dismiss(animated: true) {
                    self.navigationController?.pushViewController(welcomeController!, animated: true)
                }
                
            }
        }
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
