//
//  FollowerListViewController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 13.11.2020.
//

import UIKit

class FollowerListViewController: GFDataLoadingViewController {
    
    // MARK: - Constructors
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Private Nested
    
    private enum Section {
        case main
    }
    
    // MARK: - Private Properties
    
    private var username: String!
    private var followers = [Follower]()
    private var filteredFollowers = [Follower]()
    private var page = 1
    private var hasMoreFollowers = true
    private var isSearching = false
    private var isLoadingMoreFollowers = false
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Private Methods
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureNavBar()
        updateHeader(with: username)
    }
    
    private func configureNavBar() {
        let myPageButton = UIBarButtonItem(title: Texts.userInfoButton.local(), style: .plain, target: self, action: #selector(self.myPageButtonTapped))
        navigationItem.rightBarButtonItem = myPageButton
    }
    
    private func updateHeader(with username: String) {
        NetworkManager.shared.getUserInfo(for: username) { (result) in
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.title = user.login }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Texts.searchPlaceholder.local()
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        let collectionViewLayout = UIHelper.createFlowLayout(in: view, columnsCount: 3)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                DispatchQueue.main.async {
                    let message = Texts.unexpectedCaseText.local()
                    self.navigationItem.searchController = nil
                    self.showEmptyStateView(with: message, in: self.view)
                }
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    @objc private func myPageButtonTapped() {
        goToUserInfoVC(username: username)
    }
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            DispatchQueue.main.async {
                let message = Texts.noFollowersText.local()
                self.navigationItem.searchController = nil
                self.showEmptyStateView(with: message, in: self.view)
            }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func goToUserInfoVC(username: String) {
        let destinationVC = UserInfoViewController()
        destinationVC.username = username
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegate

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !isSearching, hasMoreFollowers, !isLoadingMoreFollowers else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        goToUserInfoVC(username: follower.login)
    }
    
}

// MARK: - UISearchResultsUpdating

extension FollowerListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
}

// MARK: - UserinfoViewControllerDelegate

extension FollowerListViewController: UserinfoViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }

}
