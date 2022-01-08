//
//  Endpoint.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

enum Endpoint {
    case shows(page: Int)
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
        }
    }
}
