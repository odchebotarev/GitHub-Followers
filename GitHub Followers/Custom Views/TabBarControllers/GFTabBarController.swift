//
//  GFTabBarController.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 16.11.2020.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    // MARK: - Public Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .mainColor
        viewControllers = [createSearchNC(), createFavoritesListNC()]
    }
    
    // MARK: - Private Methods
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavoritesListNC() -> UINavigationController {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}
