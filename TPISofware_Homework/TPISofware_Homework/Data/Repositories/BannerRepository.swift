//
//  BannerRepository.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

protocol BannerRepositoryProtocol {
    func getBannerData() -> AnyPublisher<[BannerListModel], Error>
}

class BannerRepository: BannerRepositoryProtocol {
    
    func getBannerData() -> AnyPublisher<[BannerListModel], Error> {
        let url = URL(string: "https://willywu0201.github.io/data/banner.json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BannerResponseModel.self, decoder: JSONDecoder())
            .map { $0.result.bannerList }
            .eraseToAnyPublisher()
        
    }
    
}
