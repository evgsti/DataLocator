//
//  NetworkManager.swift
//  DataLocator
//
//  Created by Евгений on 04.09.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(url: URL, completion: @escaping (Result<Location, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    let location = Location.getLocation(from: data)
                    completion(.success(location))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
