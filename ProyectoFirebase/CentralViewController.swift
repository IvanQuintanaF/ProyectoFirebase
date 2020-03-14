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
    let photosController = FlickrViewController()
    let saveController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configControllers()
    }
    
    func configControllers() {
        tabBar.tintColor = .black
        
        profileController.tabBarItem.image = UIImage(systemName: "person.fill")
        profileController.tabBarItem.title = "Perfil"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionViewController = FlickrViewController(collectionViewLayout: layout)
        collectionViewController.tabBarItem.image = UIImage(systemName: "square.grid.2x2.fill")
        collectionViewController.tabBarItem.title = "Photos"
        let photosNavController = UINavigationController(rootViewController: collectionViewController)
        
        let saveNavCon = UINavigationController(rootViewController: saveController)
        saveController.tabBarItem.image = UIImage(systemName: "tray.and.arrow.down.fill")
        saveController.tabBarItem.title = "Favorites"
        
        self.viewControllers = [profileController, photosNavController, saveNavCon ]
    }
}
