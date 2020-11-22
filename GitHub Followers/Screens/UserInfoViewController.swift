//
//  UserInfoViewController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import UIKit

protocol UserinfoViewControllerDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {
    
    // MARK: - Public Properties
    
    var username: String!
    weak var delegate: UserinfoViewControllerDelegate!
    
    // MARK: - Constructors
    
    init(persistenceService: PersistenceService) {
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
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    // MARK: - Private Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    
    private let persistenceService: PersistenceService
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        
        configureNavBar()
    }
    
    private func configureNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.configureLeftBarButtonItem(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func configureLeftBarButtonItem(user: User) {
        let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
        persistenceService.isFavorite(follower: follower) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let isFavorite):
                self.configureAddBarButtonItem(isFavorite: isFavorite)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func configureAddBarButtonItem(isFavorite: Bool) {
        DispatchQueue.main.async {
            if !isFavorite {
                let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonTapped))
                self.navigationItem.leftBarButtonItem = leftButton
            } else {
                self.navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func layoutUI() {
        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 150
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func configureUIElements(with user: User) {
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemViewController(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemViewController(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "\(Texts.gitHubSince.local()) \(user.createdAt.convertToMonthYearFormat())"
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc private func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
            }
        }
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        persistenceService.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
            guard let self = self else { return }
            if let error = error {
                self.presentGFAlertOnMainThread(title: Texts.defaultErrorLabel.local(), message: error.localizedDescription)
                return
            }
            
            self.presentGFAlertOnMainThread(title: Texts.successLabel.local(), message: Texts.favoritedMessage.local(), buttonTitle: Texts.hoorayButton.local())
            self.configureAddBarButtonItem(isFavorite: true)
        }
    }
    
}

// MARK: - GFRepoItemViewControllerDelegate

extension UserInfoViewController: GFRepoItemViewControllerDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: Texts.invalidUrlLabel.local(), message: Texts.invalidUrlMessage.local())
            return
        }
        
        presentSafariVC(with: url)
    }
    
}

// MARK: - GFFollowerItemViewControllerDelegate

extension UserInfoViewController: GFFollowerItemViewControllerDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: Texts.noFollowersLabel.local(), message: Texts.noFollowersMessage.local())
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
