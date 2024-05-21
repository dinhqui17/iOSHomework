//
//  HomeViewModel1.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation
import Combine


class BalanceViewModel {
    @Published private(set) var isShowBalance: Bool = true
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error?
    @Published private(set) var usdBalanceValue: Double = 0.0
    @Published private(set) var khrBalanceValue: Double = 0.0
    
    init(usdBalanceRepository: HomeBalanceRepository, khrBalanceRepository: HomeBalanceRepository) {
        self.usdBalanceRepository = usdBalanceRepository
        self.khrBalanceRepository = khrBalanceRepository
    }
    
    private let usdBalanceRepository: HomeBalanceRepository
    private let khrBalanceRepository: HomeBalanceRepository
    private var requestDataCancellable: AnyCancellable? {
        willSet {
            requestDataCancellable?.cancel()
        }
    }
    
    func toggleShowBalance() {
        isShowBalance.toggle()
    }
    
    func refreshBalance() {
        isLoading = true
        requestDataCancellable = Publishers.Zip(usdBalanceRepository.getHomeBalance(), khrBalanceRepository.getHomeBalance())
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.error = nil
                    break
                case .failure(let error):
                    self?.error = error
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (usdBalance, khrBalance) in
                self?.usdBalanceValue = usdBalance
                self?.khrBalanceValue = khrBalance
            }
    }
}
