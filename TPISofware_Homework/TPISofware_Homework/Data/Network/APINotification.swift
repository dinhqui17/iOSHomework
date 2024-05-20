//
//  APINotification.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation
import Combine

enum NotificationType: String {
    case empty = "emptyNotificationList.json"
    case notEmpty = "notificationList.json"
}

class APINotification {
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    
    func getNotifications(endpoint: NotificationType) -> AnyPublisher<NotificationResponseModel, APIError> {
        
        let url = URL(string: APIService.shared.baseUrl + endpoint.rawValue)!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .subscribe(on: apiQueue)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.invalidResponse
                }
                return output.data
            }
            .decode(type: NotificationResponseModel.self, decoder: decoder)
            .mapError { error -> APIError in
                switch error {
                case is URLError:
                    return .errorURL
                case is DecodingError:
                    return .errorParsing
                default:
                    return error as? APIError ?? .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
