//
//  NotificationRepository.swift
//  TPISofware_Homework
//
//  Created by vfa on 21/05/2024.
//

import Foundation
import Combine

protocol NotificationRepositoryProtocol {
    func getNotificationData() -> AnyPublisher<[NotificationMessagesModel], Error>
}

class NotificationRepository: NotificationRepositoryProtocol {
    
    private var isRefresh: Bool = false
    
    func getNotificationData() -> AnyPublisher<[NotificationMessagesModel], Error> {
        let url = URL(string: isRefresh ? "https://willywu0201.github.io/data/notificationList.json" : "https://willywu0201.github.io/data/emptyNotificationList.json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                self.isRefresh = true
                return data
            }
            .decode(type: NotificationResponseModel.self, decoder: JSONDecoder())
            .map { $0.result.messages }
            .eraseToAnyPublisher()
    }
    
    
}
