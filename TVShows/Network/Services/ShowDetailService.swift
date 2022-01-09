//
//  ShowDetailService.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

class ShowDetailService: ShowDetailProviding {
    var network: Networking

    init(network: Networking) {
        self.network = network
    }
}
