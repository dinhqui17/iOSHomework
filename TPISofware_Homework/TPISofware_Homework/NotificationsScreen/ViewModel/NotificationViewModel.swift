//
//  NotificationViewModel.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation
import Combine

class NotificationViewModel {
    
    let api = APINotification()
    var subscriptions = Set<AnyCancellable>()
    
    
    func getNotifications(endpoint: NotificationType) -> Future<[NotificationMessagesModel], Error> {
        return Future { promise in
            self.api.getNotifications(endpoint: endpoint)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { result in
                    
                    promise(.success(result.result.messages))
                })
                .store(in: &self.subscriptions)
        }
    }
    }
    

