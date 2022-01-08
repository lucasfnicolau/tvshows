//
//  UICell+ReuseIdentifier.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionViewCell{
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
