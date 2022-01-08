//
//  ShowsListViewModel.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol ShowsListViewModelProtocol {
    var title: String { get }
    var shows: [Show] { get }
    var coordinator: MainCoordinator? { get }
    var service: ShowsListProviding { get }

    init(coordinator: MainCoordinator, service: ShowsListProviding)

    /// Fetch the tv shows list.
    /// - Parameters:
    ///   - forPage: Int controlling the pagination.
    ///   - completion: The completion block to be executed after the fetch request is done.
    ///
    func fetchShows(forPage page: Int, completion: @escaping (NetworkError?) -> Void)

    /// Navigate to the chosen show details.
    /// - Parameter index: Index of the selected show.
    func navigateToShowDetails(atIndex index: Int)
}

class ShowsListViewModel: ShowsListViewModelProtocol {
    var shows: [Show] = []
    weak var coordinator: MainCoordinator?
    var service: ShowsListProviding

    var title: String {
        return NSLocalizedString("TV_SHOWS", comment: "")
    }

    required init(coordinator: MainCoordinator, service: ShowsListProviding) {
        self.coordinator = coordinator
        self.service = service
    }

    func fetchShows(forPage page: Int = 1, completion: @escaping (NetworkError?) -> Void) {
        service.getShows(forPage: page) { result in
            switch result {
            case .success(let shows):
                if (page > 1) {
                    self.shows.append(contentsOf: shows)
                } else {
                    self.shows = shows
                }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func navigateToShowDetails(atIndex index: Int) {
        // TODO
    }
}
