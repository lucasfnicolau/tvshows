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
        let service = ShowsListService(network: APIClient.shared)
        let viewModel = ShowsListViewModel(coordinator: self, service: service)
        let viewController = ShowsListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
