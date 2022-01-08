//
//  UIStackView+BuildStack.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIStackView {
    static func buildStack(arrangedSubviews: [UIView],
                           axis: NSLayoutConstraint.Axis = .horizontal,
                           distribution: Distribution = .fill,
                           alignment: Alignment = .fill,
                           spacing: CGFloat = DesignSystem.Spacing.small) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        return stackView
    }
}
