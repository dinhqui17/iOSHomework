//
//  NotificationViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation
import Combine

class NotificationViewModel {
    
    @Published private(set) var notifications: [NotificationMessagesModel] = []
    @Published private(set) var hasNewNotify: Bool = false
    
    private let notificationRepository: NotificationRepository
    
    private var requestDataCancellable: AnyCancellable? {
        willSet {
            requestDataCancellable?.cancel()
        }
    }
    
    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }
    
    
    func loadNotification() {
        requestDataCancellable = notificationRepository.getNotificationData()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] results in
                self?.hasNewNotify = !results.isEmpty
                self?.notifications = results
            }
    }
    
}


