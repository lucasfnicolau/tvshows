//
//  MainTabBarController.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    let mainCoordinator: MainCoordinator = MainCoordinator(navigationController: .init())

    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator.start()
        viewControllers = [mainCoordinator.navigationController]
    }
}
