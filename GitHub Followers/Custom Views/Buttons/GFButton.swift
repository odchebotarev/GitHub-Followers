//
//  GFButton.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 12.11.2020.
//

import UIKit

class GFButton: UIButton {
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        
        set(backgroundColor: backgroundColor, title: title)
    }
    
    // MARK: - Public Methods
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
    // MARK: - Private Methods

    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
