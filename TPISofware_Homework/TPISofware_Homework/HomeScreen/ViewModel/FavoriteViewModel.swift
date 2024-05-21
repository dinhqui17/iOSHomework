//
//  FavoriteViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

class FavoriteViewModel {
    @Published private(set) var favorites: [FavoriteListModel] = []
    private let favoriterRepository: FavoriteRepository
    
    init(favoriterRepository: FavoriteRepository) {
        self.favoriterRepository = favoriterRepository
    }
    
    private var requestDataCancellable: AnyCancellable? {
        willSet {
            requestDataCancellable?.cancel()
        }
    }
    
    func loadFavorites() {
        requestDataCancellable = favoriterRepository.getFavoriteData()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] results in
                self?.favorites = results
            }
    }
}
