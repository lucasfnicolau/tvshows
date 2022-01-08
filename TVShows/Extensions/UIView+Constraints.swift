//
//  UIView+Constraints.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIView {

    @discardableResult
    /// Constraint the current view topAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintTop(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Self {
        self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view leadingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintLeading(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Self {
        self.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view trailingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintTrailing(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Self {
        self.trailingAnchor.constraint(equalTo: anchor, constant: (constant <= 0 ? constant : constant * -1)).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view bottomAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintBottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Self {
        self.bottomAnchor.constraint(equalTo: anchor, constant: (constant <= 0 ? constant : constant * -1)).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view centerY and centerX anchors with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintCenter(to view: UIView) -> Self {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view centerYAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintCenterY(to view: UIView) -> Self {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view centerXAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintCenterX(to view: UIView) -> Self {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
  /// Constraint all the four main anchors (top, leading, trailing and bottom) of the current view with the anchor received by paremeter.
  /// - Parameters:
  ///   - view: The view where the constraint should be applied to.
  ///   - usingSafeArea: Boolean controlling the use of the safe area when applying the constraints.
  ///   - constant: A custom constant to be used in the constraints.
    func constraint(to view: UIView, usingSafeArea: Bool = false, constant: CGFloat = 0) -> Self {
        if (usingSafeArea) {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
            ])
        }
        return self
    }

    @discardableResult
    /// Constraint the height and width anchors with the specified CGSize value.
    /// - Parameters:
    ///   - size: The size be used as the constraint constant.
    func constraintSize(to size: CGSize) -> Self {
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the height and width anchors with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value to be used as the constraint constant.
    func constraintSize(to constant: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the widthAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    func constraintWidth(to constant: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the widthAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintWidth(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        self.widthAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the heightAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    func constraintHeight(to constant: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the heightAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintHeight(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        self.heightAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }
}
