//
//  GFItemInfoView.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import UIKit


class GFItemInfoView: UIView {
    
    // MARK: - Public Nested
    
    enum ItemInfoType {
        case repos, gists, followers, following
    }
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = Texts.publicReposHeader.local()
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = Texts.publicGistsHeader.local()
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = Texts.followersHeader.local()
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = Texts.followingHeader.local()
        }
        titleLabel.numberOfLines = titleLabel.text?.split(separator: " ").count == 1 ? 1 : 2
        
        countLabel.text = String(count)
    }
    
    // MARK: - Private Properties
    
    private let symbolImageView = UIImageView()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 18)
    
    // MARK: - Private Methods
    
    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
