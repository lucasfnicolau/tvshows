//
//  MainCoordinator.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
