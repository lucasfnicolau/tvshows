//
//  ShowDetailProviding.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol ShowDetailProviding: Providing {
    func getShowDetail(forId id: Int, completion: @escaping (Result<Show, NetworkError>) -> Void)
    func getSeasons(forShowId id: Int, completion: @escaping (Result<[Season], NetworkError>) -> Void)
    func getEpisodes(forShowId id: Int, completion: @escaping (Result<[Episode], NetworkError>) -> Void)
}

extension ShowDetailProviding {
    func getShowDetail(forId id: Int, completion: @escaping (Result<Show, NetworkError>) -> Void) {
        network.execute(Endpoint.showDetail(id: id), completion: completion)
    }

    func getSeasons(forShowId id: Int, completion: @escaping (Result<[Season], NetworkError>) -> Void) {
        network.execute(Endpoint.seasons(id: id), completion: completion)
    }

    func getEpisodes(forShowId id: Int, completion: @escaping (Result<[Episode], NetworkError>) -> Void) {
        network.execute(Endpoint.episodes(id: id), completion: completion)
    }
}
