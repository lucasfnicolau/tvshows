//
//  Coordinator.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }

    /// Start a coordinator with initial configurations.
    func start()
}
