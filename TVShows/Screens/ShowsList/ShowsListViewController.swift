//
//  ShowsListViewController.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import UIKit

class ShowsListViewController: UIViewController {
    // MARK: - Constant

    private enum Constant {
        static let cellHeight: CGFloat = UIScreen.main.bounds.height / 6.5
    }

    // MARK: - Properties

    private enum Section {
        case main
    }

    private var currentPage: Int = 1
    private var shouldFetchUsingPagination: Bool = true
    private let viewModel: ShowsListViewModelProtocol
    private lazy var dataSource: UITableViewDiffableDataSource<Section, Show> = createDataSource()

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Initializers

    init(viewModel: ShowsListViewModelProtocol) {
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
        setUpSearchBar()
        self.tabBarItem = .init(title: self.viewModel.title,
                                image: DesignSystem.Image.tvShowsTabItem,
                                selectedImage: DesignSystem.Image.tvShowsSelectedTabItem)
    }

    // MARK: - Methods

    private func setUpSearchBar() {
        self.title = self.viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.searchTextField.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }

    private func createDataSource() -> UITableViewDiffableDataSource<Section, Show> {
        let dataSource = UITableViewDiffableDataSource<Section, Show>(tableView: self.tableView) { (tableView, indexPath, show) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: ShowsListItemCell.reuseIdentifier, for: indexPath) as? ShowsListItemCell

            let position: ShowsListItemCell.Position
            if self.viewModel.shows.count == 1 {
                position = .unique
            } else {
                switch indexPath.item {
                case .zero:
                    position = .first
                case (self.viewModel.shows.count - 1):
                    position = .last
                default:
                    position = .default
                }
            }

            cell?.setUp(for: show, position: position)
            return cell
        }
        return dataSource
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Show>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.shows)
        self.dataSource.apply(snapshot)
    }
}

// MARK: - ViewCodable

extension ShowsListViewController: ViewCodable {
    func setUpViews() {
        self.view.backgroundColor = DesignSystem.Color.background
        self.view.addSubview(self.tableView)
        self.tableView.register(ShowsListItemCell.self, forCellReuseIdentifier: ShowsListItemCell.reuseIdentifier)
        self.tableView.backgroundColor = .clear
        self.tableView.delegate = self
    }

    func setUpConstraints() {
        self.tableView.constraint(to: self.view, constant: DesignSystem.Spacing.default)
    }

    func updateUI() {
        self.viewModel.fetchShows(forPage: self.currentPage) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showErrorAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                                         message: error.rawValue)
                    return
                }
                self?.updateSnapshot()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ShowsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }
}

// MARK: - UISearchResultsUpdating

extension ShowsListViewController: UISearchResultsUpdating, UITextFieldDelegate {
    // The search operation is being performed only when touching "search"
    // on the keyboard (or pressing "enter" when using the simulator),
    // to avoid performing a lot of reauests by second.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.search(textField.text) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showErrorAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                                         message: error.rawValue)
                    return
                }
                self?.shouldFetchUsingPagination = false
                self?.updateSnapshot()
            }
        }
        return true
    }

    // Perform a fetch request when the search bar text becomes empty to reload the shows.
    func updateSearchResults(for searchController: UISearchController) {
        guard let emptyText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), emptyText.isEmpty else { return }
        viewModel.fetchShows(forPage: self.currentPage) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showErrorAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                                         message: error.rawValue)
                    return
                }
                self?.shouldFetchUsingPagination = true
                self?.updateSnapshot()
            }
        }
    }
}
