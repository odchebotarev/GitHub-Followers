//
//  GFRepoItemViewController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: GFRepoItemViewControllerDelegate!
    
    // MARK: - Constructors
    
    init(user: User, delegate: GFRepoItemViewControllerDelegate) {
        super.init(user: user)
        
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }

    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    // MARK: - Private Methods
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .profileButtonColor, title: Texts.gitHubProfileButton.local())
    }
    
}
