//
//  Network.swift
//  GitHubFollowers
//
//  Created by Kevin Lloyd Tud on 1/18/24.
//

import UIKit

class Network {
    
    static let shared = Network()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getBanner(completion: @escaping(Result<UIImage, ErrMessages>) -> Void) {
        let imageUrl = "https://dev.lampawta.com/images/2023_banner.jpg"
            guard let url = URL(string: imageUrl) else {
                completion(.failure(.cantFetchBanner))
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completion(.failure(.unableToComplete))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.unableToComplete))
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(.invalidData))
                    return
                }

                completion(.success(image))
            }
            
            task.resume()
    }
    
//    func getUserInfo(for username: String, completed: @escaping(Result<User, ErrMessages>) -> Void) {
//        let endpoint = baseURL + "\(username)"
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                decoder.dateDecodingStrategy = .iso8601
//                let user = try decoder.decode(User.self, from: data)
//                completed(.success(user))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        
//        task.resume()
//    }
}
