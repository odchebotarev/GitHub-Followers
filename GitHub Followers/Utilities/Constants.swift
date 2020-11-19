//
//  Constants.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import UIKit

enum SFSymbols {
    
    static let location     = UIImage(systemName: "mappin.and.ellipse")
    static let repos        = UIImage(systemName: "folder")
    static let gists        = UIImage(systemName: "text.alignleft")
    static let followers    = UIImage(systemName: "heart")
    static let following    = UIImage(systemName: "person.2")
    
}

enum Images {
    
    static let ghLogo           = UIImage(named: "gh-logo")
    static let placeholder      = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo   = UIImage(named: "empty-state-logo")
    
}

enum ScreenSize {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
    
}

enum DeviceTypes {
    
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad   && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
    
}

enum Texts: String {
    
    // Buttons
    case getFollowersButton = "Get followers"
    case userInfoButton = "User Info"
    case gitHubProfileButton = "GitHub Profile"
    case hoorayButton = "Hooray!"
    case okButton = "Ok"
    
    // Placeholders
    case usernamePlaceholder = "Enter a username"
    case searchPlaceholder = "Search for a username"
    
    // Alerts
    case defaultErrorLabel = "Something went wrong"
    
    case emptyUsernameErrorLabel = "Empty username"
    case emptyUsernameErrorMessage = "Please enter a username. We need to know who to look for!"
    
    case successLabel = "Success!"
    case unableToRemoveLabel = "Unable to remove"
    
    case invalidUrlLabel = "Invalid URL"
    case invalidUrlMessage = "The URL attached to this user is invalid"
    
    case noFollowersLabel = "No followers"
    case noFollowersMessage = "This user has no followers. What a shame!"
    
    case favoritedMessage = "You have successfully favorited this user."
    
    // User Info Elements
    case publicReposHeader = "Public Repos"
    case publicGistsHeader = "Public Gists"
    case followersHeader = "Followers"
    case followingHeader = "Following"
    
    // Error Messages
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
    
    // Other
    case noFollowersText = "This user doesn't have any followers. Go follow them!"
    case noFavoritesText = "No favorites!\nAdd one on the search tab."
    case unexpectedCaseText = "Oops! That's not what was planned to be."
    case noLocationText = "No Location"
    case noBioText = "No bio available"
    case favoritesHeader = "Favorites"
    case gitHubSince = "GitHub since"
    
    func local() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
}
