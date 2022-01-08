//
//  UIView+BuildSeparator.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIView {
    static func buildSeparator(withColor color: UIColor) -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.layer.cornerRadius = DesignSystem.Size.separatorHeight / 2
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        return view
    }
}
