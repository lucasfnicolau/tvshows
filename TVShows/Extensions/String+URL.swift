//
//  String+URL.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

extension String {
    func parsedForURL() -> String {
        return self.replacingOccurrences(of: " ", with: "%20")
    }
}
