//
//  EpisodeListItemCell.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class EpisodeListItemCell: UITableViewCell {
    // MARK: - Methods

    func setUp(for episode: Episode) {
        self.textLabel?.text = episode.name
    }
}
