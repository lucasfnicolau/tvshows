//
//  ShowsListProviding.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol ShowsListProviding: Providing {
    /// Get shows from TVMaze API.
    func getShows(forPage page: Int, completion: @escaping (Result<[Show], NetworkError>) -> Void)
}

extension ShowsListProviding {
    func getShows(forPage page: Int, completion: @escaping (Result<[Show], NetworkError>) -> Void) {
        network.execute(Endpoint.shows(page: page), completion: completion)
    }
}
