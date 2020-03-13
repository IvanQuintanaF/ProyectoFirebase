//
//  MainViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 07/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        isLogged()
    }
    
    func isLogged() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                print("user not logged")
                return
            } else {
                print("User is logged")
                self.performSegue(withIdentifier: "welcomeView", sender: nil)
            }
            
        }
        
    }
}
