//
//  DesignSystem.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

struct DesignSystem {
  struct Spacing {
      static let small: CGFloat = 8
      static let `default`: CGFloat = 16
      static let large: CGFloat = 20
  }

  struct CornerRadius {
      static let `default`: CGFloat = 10
  }

  struct FontSize {
      static let regular: CGFloat = 17
  }

  struct Image {
      static let fallbackProfile = UIImage(named: "profile_placeholder")
      static let fallbackTVShow = UIImage(named: "tv_show_placeholder")
  }
}
