//
//  GFAvatarImageView.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 14.11.2020.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    // MARK: - Public Properties
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setImageToPlaceholder() {
        image = placeholderImage
    }
    
    // MARK: - Private Properties
    
    private let placeholderImage = Images.placeholder
    
    // MARK: - Private Methods

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setImageToPlaceholder()
    }
    
}
