//
//  BannerViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

class BannerViewModel {
    
    @Published var banners: [BannerListModel] = []
    @Published var currentPage: Int = 0
    
    private let bannerRepository: BannerRepository
    
    
    init(bannerRepository: BannerRepository) {
        self.bannerRepository = bannerRepository
    }
    
    private var requestDataCancellable: AnyCancellable? {
        willSet {
            requestDataCancellable?.cancel()
        }
    }
    
    func updateCurrentPage(currentPage: Int) {
        self.currentPage = currentPage
    }
    
    
    func loadBanners(viewModel: BannerViewModel) {
        requestDataCancellable = bannerRepository.getBannerData()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] results in
                self?.banners = results
            }
    }
}
