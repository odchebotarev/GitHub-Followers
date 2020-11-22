//
//  FollowerCell.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 14.11.2020.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    static let reuseID = "FollowerCell"
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    override func prepareForReuse() {
        avatarImageView.setImageToPlaceholder()
        usernameLabel.text = nil
    }
    
    func set(follower: Follower, networkService: Networking) {
        usernameLabel.text = follower.login
        self.networkService = networkService
        downloadImage(of: follower)
    }
    
    // MARK: - Private Properties
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    private var networkService: Networking?
    
    // MARK: - Private Methods
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
    private func downloadImage(of follower: Follower) {
        networkService?.downloadImage(from: follower.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.usernameLabel.text == follower.login {
                    self.avatarImageView.image = image
                }
            }
        }
    }
    
}
