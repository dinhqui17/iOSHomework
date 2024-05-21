//
//  MiddleButtonViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

class MiddleButtonViewModel {
    
    @Published var middleButtons: [MiddleButtonItemModel] = []
    
    private let middleButtonRepository: MiddleButtonRepository
    
    private var requestDataCancellable: AnyCancellable? {
        willSet {
            requestDataCancellable?.cancel()
        }
    }
    
    init(middleButtonRepository: MiddleButtonRepository) {
        self.middleButtonRepository = middleButtonRepository
    }
    
    func loadMiddleButtons() {
        requestDataCancellable = middleButtonRepository.getMiddleButtonItems
            .publisher.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] results in
                self?.middleButtons.append(results)
            })
        
    }
    
}
