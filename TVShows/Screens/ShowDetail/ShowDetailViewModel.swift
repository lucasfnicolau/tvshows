//
//  ShowDetailViewModel.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol ShowDetailViewModelProtocol {
    var title: String { get }
    var show: Show { get }
    var episodes: [[Episode]] { get }
    var seasonsCount: Int { get  }
    var coordinator: MainCoordinator? { get }
    var service: ShowDetailProviding { get }

    init(coordinator: MainCoordinator, service: ShowDetailProviding, show: Show)

    func fetchShowDetail(completion: @escaping (NetworkError?) -> Void)

    func fetchShowSeasons(completion: @escaping (NetworkError?) -> Void)

    func fetchShowEpisodes(completion: @escaping (NetworkError?) -> Void)
}

class ShowDetailViewModel: ShowDetailViewModelProtocol {
    var title: String {
        NSLocalizedString("DETAILS", comment: "")
    }

    var show: Show
    var episodes: [[Episode]] = []
    var seasonsCount: Int = 0
    var coordinator: MainCoordinator?
    var service: ShowDetailProviding

    required init(coordinator: MainCoordinator, service: ShowDetailProviding, show: Show) {
        self.coordinator = coordinator
        self.service = service
        self.show = show
    }

    func fetchShowDetail(completion: @escaping (NetworkError?) -> Void) {
        service.getShowDetail(forId: show.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }

    func fetchShowSeasons(completion: @escaping (NetworkError?) -> Void) {
        service.getSeasons(forShowId: show.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let seasons):
                    self.seasonsCount = seasons.count
                    self.episodes = Array(repeating: [], count: self.seasonsCount)
                    self.fetchShowEpisodes(completion: completion)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }

    func fetchShowEpisodes(completion: @escaping (NetworkError?) -> Void) {
        service.getEpisodes(forShowId: show.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episodes):
                    for index in .zero ..< self.seasonsCount {
                        self.episodes[index] = episodes.filter { ($0.season ?? .zero) == (index + 1) }
                    }
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
}
