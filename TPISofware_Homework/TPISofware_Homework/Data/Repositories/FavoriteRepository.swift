//
//  FavoriteRepository.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

protocol FavoriteRepositoryProtocol {
    func getFavoriteData() -> AnyPublisher<[FavoriteListModel], Error>
}

class FavoriteRepository: FavoriteRepositoryProtocol {
    
    private var isRefresh: Bool = false
    
    func getFavoriteData() -> AnyPublisher<[FavoriteListModel], Error> {
        let url = URL(string: !isRefresh ? "https://willywu0201.github.io/data/emptyFavoriteList.json" : "https://willywu0201.github.io/data/favoriteList.json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                self.isRefresh = true
                return data
            }
            .decode(type: FavoriteResponseModel.self, decoder: JSONDecoder())
            .map { $0.result.favoriteList }
            .eraseToAnyPublisher()
    }
    
    
}
