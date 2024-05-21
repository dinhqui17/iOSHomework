//
//  HomeViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 19/05/2024.
//

import UIKit
import Combine

class HomeViewModel2 {
    
    private var apiBalance = APIBalance()
    private var apiBanner = APIBanner()
    var subscriptions = Set<AnyCancellable>()
    var initialFetchCancellable = Set<AnyCancellable>()
    var refreshFetchCancellable = Set<AnyCancellable>()
    
    
    @Published var currentPage: Int = 0
    
    @Published var bottomBarItems: [BottomBarItemModel] = [
        BottomBarItemModel(label: "Home", image: "icTabbarHomeActive"),
        BottomBarItemModel(label: "Account", image: "icTabbarAccountDefault"),
        BottomBarItemModel(label: "Location", image: "icTabbarLocationActive"),
        BottomBarItemModel(label: "Service", image: "icTabbarLocationActive")
    ]
    
    

    
    @Published var isShowBalance: Bool = true
    @Published var banners: [BannerListModel] = []

    
    func getBanner() {
        self.apiBanner.getBanner()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [self] result in
                banners = result.result.bannerList
            })
            .store(in: &self.subscriptions)
    }
}



