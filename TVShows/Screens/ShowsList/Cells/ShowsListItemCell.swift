//
//  ShowsListItemCell.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class ShowsListItemCell: UITableViewCell {
    // MARK: - Constants

    private enum Constant {
        static let imageHeight: CGFloat = 110
        static let imageWidth: CGFloat = 0.68 * imageHeight
    }

    // MARK: - Properties

    enum Position {
        case first
        case `default`
        case last
        case unique
    }

    // MARK: - Views

    private lazy var showImageView: RoundedImageView = RoundedImageView(cornerRadius: DesignSystem.CornerRadius.default)
    private lazy var showTitleLabel: UILabel = .buildLabel(withFontSize: DesignSystem.FontSize.title,
                                                           numberOfLines: 2)
    private lazy var showYearsLabel: UILabel = .buildLabel(withFontSize: DesignSystem.FontSize.body,
                                                           textColor: DesignSystem.Color.bodyText)
    private lazy var showCountryLabel: UILabel = .buildLabel(withFontSize: DesignSystem.FontSize.subtitle,
                                                             textColor: DesignSystem.Color.subtitleText)
    private lazy var showAverageLabel: UILabel = .buildLabel()
    private lazy var separator: UIView = .buildSeparator(withColor: DesignSystem.Color.separator)
    private lazy var stackView: UIStackView = .buildStack(arrangedSubviews: [showTitleLabel,
                                                                             showYearsLabel,
                                                                             showCountryLabel],
                                                          axis: .vertical)

    // MARK: - Lifecycle

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUpViews()
        setUpConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.showImageView.image = nil
    }

    // MARK: - Methods

    func setUp(for show: Show, position: Position) {
        self.showImageView.loadImage(from: show.image?.medium ?? .init())
        self.showTitleLabel.text = show.name
        self.showCountryLabel.text = show.network?.country?.name
        setUpAverageLabel(for: show)
        setUpYearsLabel(for: show)

        switch position {
        case .first:
            self.separator.isHidden = false
            self.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .last:
            self.separator.isHidden = true
            self.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .unique:
            self.separator.isHidden = true
            self.selectedBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        default:
            self.separator.isHidden = false
            self.selectedBackgroundView?.layer.maskedCorners = []
            self.layer.maskedCorners = []
        }
    }

    private func setUpYearsLabel(for show: Show) {
        if let premiered = show.premiered {
            self.showYearsLabel.text = "\(premiered.asDate())"
        }

        guard self.showYearsLabel.text != nil else { return }
        if let ended = show.ended {
            self.showYearsLabel.text! += " - \(ended.asDate())"
        } else {
            self.showYearsLabel.text! += " - \(NSLocalizedString("ONGOING", comment: ""))"
        }
    }

    private func setUpAverageLabel(for show: Show) {
        if let average = show.rating?.average {
            self.showAverageLabel.text = "\(average) ⭐️"
        } else {
            self.showAverageLabel.text = "– ⭐️"
        }
    }
}

// MARK: - ViewCodable

extension ShowsListItemCell: ViewCodable {
    func setUpViews() {
        self.backgroundColor = DesignSystem.Color.cardBackground
        self.layer.cornerRadius = DesignSystem.CornerRadius.default
        self.selectedBackgroundView?.layer.cornerRadius = DesignSystem.CornerRadius.default

        self.contentView.addSubview(self.showImageView)
        self.contentView.addSubview(self.stackView)
        self.contentView.addSubview(self.showAverageLabel)
        self.contentView.addSubview(self.separator)
    }

    func setUpConstraints() {
        self.showImageView.constraintTop(to: self.contentView.topAnchor,
                                         constant: DesignSystem.Spacing.small)
        self.showImageView.constraintLeading(to: self.contentView.leadingAnchor,
                                             constant: DesignSystem.Spacing.small)
        self.showImageView.constraintBottom(to: self.contentView.bottomAnchor,
                                            constant: DesignSystem.Spacing.small)
        self.showImageView.constraintHeight(to: Constant.imageHeight)
        self.showImageView.constraintWidth(to: Constant.imageWidth)

        self.stackView.constraintCenterY(to: self)
        self.stackView.constraintLeading(to: self.showImageView.trailingAnchor,
                                         constant: DesignSystem.Spacing.small)
        self.stackView.constraintTop(to: self.topAnchor,
                                     constant: DesignSystem.Spacing.small,
                                     distance: .greaterThanOrEqualTo)
        self.stackView.constraintBottom(to: self.bottomAnchor,
                                        constant: DesignSystem.Spacing.small,
                                        distance: .lessThanOrEqualTo)
        self.stackView.constraintTrailing(to: self.showAverageLabel.leadingAnchor,
                                          constant: DesignSystem.Spacing.small,
                                          distance: .lessThanOrEqualTo)

        self.showAverageLabel.constraintCenterY(to: self.contentView)
        self.showAverageLabel.constraintTrailing(to: self.contentView.trailingAnchor,
                                                 constant: DesignSystem.Spacing.small)

        self.separator.constraintHeight(to: DesignSystem.Size.separatorHeight)
        self.separator.constraintLeading(to: self.contentView.leadingAnchor,
                                         constant: DesignSystem.Spacing.default)
        self.separator.constraintTrailing(to: self.contentView.trailingAnchor)
        self.separator.constraintBottom(to: self.contentView.bottomAnchor)
    }

    func updateUI() {}
}
