//
//  ShowsListService.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

class ShowsListService: ShowsListProviding {
    var network: Networking

    init(network: Networking) {
        self.network = network
    }
}
