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

    /// Search by a TV Show using a given name.
    func search(_ showName: String, completion: @escaping (Result<[SearchResult], NetworkError>) -> Void)
}

extension ShowsListProviding {
    func getShows(forPage page: Int, completion: @escaping (Result<[Show], NetworkError>) -> Void) {
        network.execute(Endpoint.shows(page: page), completion: completion)
    }

    func search(_ showName: String, completion: @escaping (Result<[SearchResult], NetworkError>) -> Void) {
        network.execute(Endpoint.search(showName: showName), completion: completion)
    }
}
