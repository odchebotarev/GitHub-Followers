//
//  FavoriteCell.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 16.11.2020.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseID = "FavoriteCell"
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if self.usernameLabel.text == favorite.login {
                    self.avatarImageView.image = image
                }
            }
        }
    }
    
    // MARK: - Private Properties
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    // MARK: - Private Methods
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        let avatarImageSideLength: CGFloat = 60
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageSideLength),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageSideLength),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
    
}
