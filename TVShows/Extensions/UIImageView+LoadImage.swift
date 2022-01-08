//
//  UIImageView+LoadImage.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

fileprivate let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    enum FallbackType {
        case `default`
        case profile
    }

    /// Load an image from an URL address (String) and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - urlAddress: The desired URL address (String).
    ///   - fallbackType: The FallbackType to be used if the desired image is not downloaded.
    func loadImage(from urlAddress: String, fallbackType: FallbackType = .default) {
        guard let url = URL(string: urlAddress) else {
            setFallbackImage(for: fallbackType)
            return
        }
        self.loadImage(from: url, fallbackType: fallbackType)
    }

    /// Load an image from an URL and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - url: The desired URL.
    ///   - fallbackType: The FallbackType to be used if the desired image is not downloaded.
    func loadImage(from url: URL, fallbackType: FallbackType = .default) {
        if let cachedImage = cache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }

        let activityIndicatorView: UIActivityIndicatorView = .buildActivityIndicator()
        self.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.constraintCenter(to: self)

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    activityIndicatorView.removeFromSuperview()
                    self.setFallbackImage(for: fallbackType)
                }
                return
            }
            DispatchQueue.main.async {
                activityIndicatorView.removeFromSuperview()
                if let image = UIImage(data: data) {
                    self.image = image
                    cache.setObject(image, forKey: NSString(string: url.absoluteString))
                } else {
                    self.setFallbackImage(for: fallbackType)
                }
            }
        }.resume()
    }

    private func setFallbackImage(for fallbackType: FallbackType) {
        switch fallbackType {
        case .`default`:
            self.image = DesignSystem.Image.fallbackTVShow
        case .profile:
            self.image = DesignSystem.Image.fallbackProfile
        }
    }
}
