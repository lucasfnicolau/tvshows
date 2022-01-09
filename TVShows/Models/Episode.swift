//
//  Episode.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

// MARK: - Episode

struct Episode: Decodable, Hashable {
    let id: Int?
    let name: String?
    let number: Int?
    let season: Int?
    let image: Image?
    let summary: String?

    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
