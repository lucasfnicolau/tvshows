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

    struct Color {
        static let background: UIColor = UIColor(named: "BackgroundColor") ?? .systemBackground
        static let cardBackground: UIColor = UIColor(named: "CardBackgroundColor") ?? .label
        static let primaryText: UIColor = .label
        static let bodyText: UIColor = UIColor(named: "BodyColor") ?? .secondaryLabel
        static let subtitleText: UIColor = UIColor(named: "SubtitleColor") ?? .secondaryLabel
        static let accent: UIColor = UIColor(named: "AccentColor") ?? .systemBlue
        static let separator: UIColor = UIColor(named: "SeparatorColor") ?? .label
    }

    struct CornerRadius {
        static let `default`: CGFloat = 10
    }

    struct FontSize {
        static let regular: CGFloat = 17
        static let title: CGFloat = 20
        static let body: CGFloat = 15
        static let subtitle: CGFloat = 13
    }

    struct Image {
        static let fallbackProfile = UIImage(named: "profile_placeholder")
        static let fallbackTVShow = UIImage(named: "tv_show_placeholder")
        static let tvShowsTabItem = UIImage(named: "tv_show_tab")
        static let tvShowsSelectedTabItem = UIImage(named: "tv_show_tab_selected")
    }

    struct Size {
        static let separatorHeight: CGFloat = 1
    }
}
