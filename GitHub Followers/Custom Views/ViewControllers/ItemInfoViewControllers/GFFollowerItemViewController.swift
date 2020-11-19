//
//  GFFollowerItemViewController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemViewController: GFItemInfoViewController {
    
    // MARK: - Public Properties
    
    weak var delegate: GFFollowerItemViewControllerDelegate!
    
    // MARK: - Constructors
    
    init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
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
        delegate.didTapGetFollowers(for: user)
    }
    
    // MARK: - Private Methods
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .getFollowersButtonColor, title: Texts.getFollowersButton.local())
    }
    
}
