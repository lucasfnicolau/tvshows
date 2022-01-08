//
//  UIViewController+ShowErrorAlert.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

extension UIViewController {
    func showErrorAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: NSLocalizedString("DISMISS", comment: ""), style: .cancel, handler: nil))
        DispatchQueue.main.async {
            if let navigationController = self.navigationController {
                navigationController.present(alertController, animated: true)
            } else {
                self.present(alertController, animated: true)
            }
        }
    }
}
