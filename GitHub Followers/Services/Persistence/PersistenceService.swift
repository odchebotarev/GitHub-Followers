//
//  PersistenceService.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 23.11.2020.
//

import Foundation

protocol PersistenceService {
    
    func updateWith(favorite: Follower,
                    actionType: PersistenceActionType,
                    completion: @escaping (GFError?) -> Void)
    func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void)
    func isFavorite(follower: Follower, completion: @escaping (Result<Bool, GFError>) -> Void)
}

enum PersistenceActionType {
    case add, remove
}
