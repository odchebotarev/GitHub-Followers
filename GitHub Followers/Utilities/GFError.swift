//
//  GFError.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import Foundation

enum GFError {
    
    case invalidUsername
    case unableToComplete
    case invalidResponse
    case invalidData
    case unableToFavorite
    case alreadyInFavorites
    
}

extension GFError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUsername:
            return Texts.invalidUsername.local()
        case .unableToComplete:
            return Texts.unableToComplete.local()
        case .invalidResponse:
            return Texts.invalidResponse.local()
        case .invalidData:
            return Texts.invalidData.local()
        case .unableToFavorite:
            return Texts.unableToFavorite.local()
        case .alreadyInFavorites:
            return Texts.alreadyInFavorites.local()
        }
    }
    
}
