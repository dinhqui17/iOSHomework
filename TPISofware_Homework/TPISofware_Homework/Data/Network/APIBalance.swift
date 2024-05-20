//
//  APIBalance.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation
import Combine

public enum BalanceType {
    case Saving
    case Digital
    case Fixed
}

public enum APIBalanceEndpointURL: String {
    case usdSavings1 = "usdSavings1.json"
    case usdFixedDeposited1 = "usdFixed1.json"
    case usdDigital1 = "usdDigital1.json"
    case khrSavings1 = "khrSavings1.json"
    case khrFixedDeposited1 = "khrFixed1.json"
    case khrDigital1 = "khrDigital1.json"
    case usdSavings2 = "usdSavings2.json"
    case usdFixedDeposited2 = "usdFixed2.json"
    case usdDigital2 = "usdDigital2.json"
    case khrSavings2 = "khrSavings2.json"
    case khrFixedDeposited2 = "khrFixed2.json"
    case khrDigital2 = "khrDigital2.json"
}

class APIBalance {
    
    
    
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "API", qos: .default, attributes: .concurrent)
    
    func getBalance(endpoint: APIBalanceEndpointURL) -> AnyPublisher<BalanceResponseModel, APIError> {
        
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
            .decode(type: BalanceResponseModel.self, decoder: decoder)
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
