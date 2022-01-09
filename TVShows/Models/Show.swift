//
//  Show.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

// MARK: - Show
struct Show: Decodable, Hashable {
    let id: Int
    let name: String?
    let genres: [String]?
    let status: String?
    let officialSite: String?
    let premiered: String?
    let ended: String?
    let schedule: Schedule?
    let rating: Rating?
    let network: Network?
    let image: Image?
    let summary: String?
    let urlAddress: String?
    var url: URL {
        guard let urlAddress = self.urlAddress, let url = URL(string: urlAddress) else {
            preconditionFailure(NetworkError.invalidURL.rawValue)
        }
        return url
    }

    enum CodingKeys: String, CodingKey {
        case id, name, genres, status, officialSite, premiered, ended, schedule, rating, network, image, summary
        case urlAddress = "url"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Show, rhs: Show) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Image
struct Image: Codable {
    let medium, original: String?
}

// MARK: - Network
struct Network: Codable {
    let id: Int?
    let name: String?
    let country: Country?
}

// MARK: - Country
struct Country: Codable {
    let name: String?
}

// MARK: - Rating
struct Rating: Codable {
    let average: Double?
}

// MARK: - Schedule
struct Schedule: Codable {
    let time: String?
    let days: [String]?
}
