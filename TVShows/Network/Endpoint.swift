//
//  Endpoint.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

enum Endpoint {
    case shows(page: Int)
    case search(showName: String)
}

extension Endpoint: URLRequestProviding {
    private static let BASE_URL = "https://api.tvmaze.com"

    var urlRequest: URLRequest {
        switch self {
        case .shows(let page):
            guard let url = URL(string: "\(Endpoint.BASE_URL)/shows?page=\(page)") else {
                preconditionFailure(NetworkError.invalidURL.rawValue)
            }
            return URLRequest(url: url)
        case .search(let showName):
            guard let url = URL(string: "\(Endpoint.BASE_URL)/search/shows?q=\(showName.parsedForURL())") else {
                preconditionFailure(NetworkError.invalidURL.rawValue)
            }
            return URLRequest(url: url)
        }
    }
}
