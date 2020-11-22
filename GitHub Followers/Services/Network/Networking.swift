//
//  NetworkService.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 23.11.2020.
//

import UIKit

protocol Networking: class {
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void)
    func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void)
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}
