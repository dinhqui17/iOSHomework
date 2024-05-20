//
//  HomeViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 19/05/2024.
//

import UIKit
import Combine

class HomeViewModel {
    
    private var apiBalance = APIBalance()
    private var apiBanner = APIBanner()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var bannerItems: [UIImage] = [
        UIImage(named: "banner")!,
        UIImage(named: "banner")!,
        UIImage(named: "banner")!
    ]
    
    @Published var currentPage: Int = 0
    
    @Published var bottomBarItems: [BottomBarItemModel] = [
        BottomBarItemModel(label: "Home", image: "icTabbarHomeActive"),
        BottomBarItemModel(label: "Account", image: "icTabbarAccountDefault"),
        BottomBarItemModel(label: "Location", image: "icTabbarLocationActive"),
        BottomBarItemModel(label: "Service", image: "icTabbarLocationActive")
    ]
    
    @Published var middleButtonItems: [MiddleButtonItemModel] = [
        MiddleButtonItemModel(label: "Transfer", image: "button00ElementMenuTransfer"),
        MiddleButtonItemModel(label: "Payment", image: "button00ElementMenuPayment"),
        MiddleButtonItemModel(label: "Utility", image: "button00ElementMenuUtility"),
        MiddleButtonItemModel(label: "QR pay scan", image: "button01Scan"),
        MiddleButtonItemModel(label: "My QR code", image: "button00ElementMenuQRcode"),
        MiddleButtonItemModel(label: "Top up", image: "button00ElementMenuTopUp")
    ]
    
    @Published var favoriteItems: [FavoriteItemModel] = [
        FavoriteItemModel(label: "Bobbyyyyy", image: "button00ElementScrollMobile"),
        FavoriteItemModel(label: "Bobbyyyyy", image: "button00ElementScrollTree"),
        FavoriteItemModel(label: "Bobbyyyyy", image: "button00ElementScrollCreditCard"),
        FavoriteItemModel(label: "Bobbyyyyy", image: "button00ElementScrollBuilding")
    ]
    
    @Published var isShowBalance: Bool = true
    @Published var banners: [BannerListModel] = []
    
    
    func getBalance(endpoint: APIBalanceEndpointURL, type: BalanceType) -> Future<Double, Error> {
        return Future { promise in
            self.apiBalance.getBalance(endpoint: endpoint)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { result in
                    let value: Double
                    switch type {
                    case .Saving:
                        value = result.result.savingsList?.first?.balance ?? 0.0
                    case .Digital:
                        value = result.result.digitalList?.first?.balance ?? 0.0
                    case .Fixed:
                        value = result.result.fixedDepositList?.first?.balance ?? 0.0
                    }
                    promise(.success(value))
                })
                .store(in: &self.subscriptions)
        }
    }
    
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



