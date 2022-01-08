//
//  RoundedImageView.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class RoundedImageView: UIImageView {
  // MARK: - Initializers

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        setUpView(cornerRadius: cornerRadius)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    private func setUpView(cornerRadius: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
