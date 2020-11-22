//
//  FavoritesListViewController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 12.11.2020.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {
    
    // MARK: - Constructors
    
    init(persistenceService: Persistencing) {
        self.persistenceService = persistenceService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
    }
    
    // MARK: - Private Properties
    
    private let tableView = UITableView()
    private var favorites = [Follower]()
    private var persistenceService: Persistencing
    
    // MARK: - Private Methods
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = Texts.favoritesHeader.local()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    private func getFavorites() {
        persistenceService.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: Texts.noFavoritesText.local(), in: self.view)
            return
        }
        
        self.favorites = favorites
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension FavoritesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite, networkService: NetworkService())
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        persistenceService.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.presentGFAlertOnMainThread(title: Texts.unableToRemoveLabel.local(), message: error.localizedDescription)
                return
            }
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.updateUI(with: self.favorites)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension FavoritesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowerListViewController(username: favorite.login, networkService: NetworkService())
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
