//
//  ShowDetailViewController.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class ShowDetailViewController: UIViewController {
    // MARK: - Constants

    private enum Constant {
        static let imageHeight: CGFloat = 220
        static let imageWidth: CGFloat = 0.68 * imageHeight
    }

    // MARK: - Properties

    private let viewModel: ShowDetailViewModelProtocol

    // MARK: - View

    private lazy var showImageView: RoundedImageView = RoundedImageView(cornerRadius: DesignSystem.CornerRadius.default)
    private lazy var showTitleLabel: UILabel = .buildLabel(withFontSize: DesignSystem.FontSize.title,
                                                           numberOfLines: .zero,
                                                           textAlignment: .center)
    private lazy var showDaysTimeLabel: UILabel = .buildLabel(numberOfLines: .zero,
                                                              textAlignment: .center)
    private lazy var showGenresLabel: UILabel = .buildLabel(numberOfLines: .zero,
                                                            textAlignment: .center)
    private lazy var showSummaryLabel: UILabel = .buildLabel(numberOfLines: .zero)
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var scrollContentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    private lazy var showEpisodesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    private lazy var stackView: UIStackView = .buildStack(arrangedSubviews: [showImageView,
                                                                             showTitleLabel,
                                                                             showDaysTimeLabel,
                                                                             showGenresLabel,
                                                                             showSummaryLabel,
                                                                             showEpisodesTableView],
                                                          axis: .vertical,
                                                          alignment: .center,
                                                          spacing: DesignSystem.Spacing.default)

    // MARK: - Initializers

    init(viewModel: ShowDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        updateUI()
    }

    // MARK: - Methods

    private func updateEpisodesList() {
        self.viewModel.fetchShowSeasons { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                                        message: error.rawValue)
                    return
                }
                self.showEpisodesTableView.reloadData()
            }
        }
    }

    private func setUpDaysTime() {
        if let schedule = self.viewModel.show.schedule {
            self.showDaysTimeLabel.text = ""
            for day in schedule.days ?? [] {
                self.showDaysTimeLabel.text! += "\(day), "
            }
            if let time = schedule.time {
                self.showDaysTimeLabel.text! += "\(time)"
            }
        }
    }

    private func setUpGenres() {
        if let genres = self.viewModel.show.genres {
            self.showGenresLabel.text = ""
            for (index, genre) in genres.enumerated() {
                self.showGenresLabel.text! += "\(genre)\(index < genres.count - 1 ? ", " : "")"
            }
        }
    }
}

// MARK: - ViewCodable

extension ShowDetailViewController: ViewCodable {
    func setUpViews() {
        self.title = self.viewModel.title
        self.view.backgroundColor = DesignSystem.Color.background
        self.view.addSubview(self.scrollView)

        self.showTitleLabel.font = .boldSystemFont(ofSize: DesignSystem.FontSize.title)

        self.scrollView.addSubview(self.scrollContentView)
        self.scrollContentView.addSubview(self.stackView)

        self.showEpisodesTableView.register(EpisodeListItemCell.self, forCellReuseIdentifier: EpisodeListItemCell.reuseIdentifier)
        self.showEpisodesTableView.dataSource = self
        self.showEpisodesTableView.delegate = self
    }

    func setUpConstraints() {
        self.scrollView.constraintCenterX(to: self.view)
        self.scrollView.constraintWidth(to: self.view.widthAnchor)
        self.scrollView.constraintTop(to: self.view.topAnchor)
        self.scrollView.constraintBottom(to: self.view.bottomAnchor)

        self.scrollContentView.constraintCenterX(to: self.scrollView)
        self.scrollContentView.constraintWidth(to: self.scrollView.widthAnchor)
        self.scrollContentView.constraintTop(to: self.scrollView.topAnchor)
        self.scrollContentView.constraintBottom(to: self.scrollView.bottomAnchor)

        self.showImageView.constraintHeight(to: Constant.imageHeight)
        self.showImageView.constraintWidth(to: Constant.imageWidth)

        self.stackView.constraint(to: self.scrollContentView, constant: DesignSystem.Spacing.default)
    }

    func updateUI() {
        self.viewModel.fetchShowDetail { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                                        message: error.rawValue)
                    return
                }

                self.showTitleLabel.text = self.viewModel.show.name
                self.showImageView.loadImage(from: self.viewModel.show.image?.medium ?? .init())
                self.setUpDaysTime()
                self.setUpGenres()

                let attributed = try? NSAttributedString(data: self.viewModel.show.summary?.data(using: .unicode) ?? Data(), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.showSummaryLabel.text = attributed?.string

                self.updateEpisodesList()
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ShowDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeListItemCell.reuseIdentifier, for: indexPath) as? EpisodeListItemCell else {
            return .init()
        }
        cell.setUp(for: self.viewModel.episodes[indexPath.section][indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < self.viewModel.episodes.count else { return .zero }
        return self.viewModel.episodes[section].count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}
