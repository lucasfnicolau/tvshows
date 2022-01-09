//
//  Season.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

struct Season: Decodable, Hashable {
    let id: Int?
    let url: String?
    let number: Int?

    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
