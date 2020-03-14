//
//  CentralViewController.swift
//  ProyectoFirebase
//
//  Created by Ivan Quintana on 13/03/20.
//  Copyright © 2020 Ivan Quintana. All rights reserved.
//

import Foundation
import UIKit

class CentralViewController: UITabBarController {

    let profileController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
    let photosController = PhotosCollectionViewController()
    let saveController = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configControllers()
    }
    
    func configControllers() {
        tabBar.tintColor = .black
        
        profileController.tabBarItem.image = UIImage(systemName: "person.fill")
        profileController.tabBarItem.title = "Perfil"
        
        let photsNavCon = UINavigationController(rootViewController: photosController)
        photosController.tabBarItem.image = UIImage(systemName: "doc.richtext")
        photosController.tabBarItem.title = "Photos"
        
        let saveNavCon = UINavigationController(rootViewController: saveController)
        saveController.tabBarItem.image = UIImage(systemName: "tray.and.arrow.down.fill")
        saveController.tabBarItem.title = "Photos"
        
        self.viewControllers = [profileController, photsNavCon, saveController]
    }
}
