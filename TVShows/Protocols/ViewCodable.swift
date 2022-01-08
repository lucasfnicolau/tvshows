//
//  ViewCodable.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol ViewCodable: AnyObject {
    /// Set up any needed configurations.
    func setUpViews()

    /// Set constraints for all views.
    func setUpConstraints()

    /// Updates UI given events.
    func updateUI()
}
