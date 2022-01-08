//
//  UIButton+BuildButton.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIButton {
    static func buildButton(withText text: String? = nil, image: UIImage? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle(text, for: .normal)
        button.setImage(image, for: .normal)

        return button
    }

    static func buildButton(withText text: String? = nil, imageNamed imageName: String? = nil) -> UIButton {
        return .buildButton(withText: text, image: UIImage(named: imageName ?? .init()))
    }
}

