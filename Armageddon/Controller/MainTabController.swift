//
//  MainTabController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

class MainTabController: UITabBarController {

//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = true
        tabBar.barTintColor = .navigationBackground
        
        configureViewControllers()
    }
    
//    MARK: - Helpers
    
    func configureViewControllers() {
        let asteroidView = templateNavigationController(image: UIImage(named: "Map"), title: "Астероиды" , rootController: ArmageddonController())
        let destructionView = templateNavigationController(image: UIImage(named: "Delete"), title: "Уничтожение" , rootController: DestructionViewController())
        
        viewControllers = [asteroidView, destructionView]
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
    }

}
