//
//  WelcomeViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 07/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: Any) {
        try? Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }
    
}
