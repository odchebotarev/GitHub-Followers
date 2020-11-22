//
//  UserDefaultsPersistenceService.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 22.11.2020.
//

import Foundation

class UserDefaultsPersistenceService: Persistencing {
    
    // MARK: - Public Methods
    
    func updateWith(favorite: Follower,
                           actionType: PersistenceActionType,
                           completion: @escaping (GFError?) -> Void) {

        retrieveFavorites { (result) in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completion(self.save(favorites: favorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = UserDefaults.standard.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    private func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            UserDefaults.standard.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    func isFavorite(follower: Follower, completion: @escaping (Result<Bool, GFError>) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(let followers):
                completion(.success(followers.contains(follower)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Nested
    
    private enum Keys {
        static let favorites =  "favorites"
    }
    
}
