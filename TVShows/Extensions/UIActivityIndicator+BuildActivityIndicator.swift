//
//  UIActivityIndicator+BuildActivityIndicator.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIActivityIndicatorView {
    static func buildActivityIndicator(style: Style = .medium) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
}
