//
//  UILabel+BuildLabel.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UILabel {
    static func buildLabel(withFontSize fontSize: CGFloat = DesignSystem.FontSize.regular,
                           textColor: UIColor = .label,
                           numberOfLines: Int = 1,
                           textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.font = .systemFont(ofSize: fontSize)
        return label
    }
}
