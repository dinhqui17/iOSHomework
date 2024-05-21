//
//  HomeBalanceRepository.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

//a. First Open
//i. USD account

//ii. KHR account
//1. Saving: https://willywu0201.github.io/data/khrSavings1.json
//2. Fixed deposited: https://willywu0201.github.io/data/khrFixed1.json
//3. Digital: https://willywu0201.github.io/data/khrDigital1.json



import Foundation
import Combine

protocol BalanceRepository {
    func getSavingData() -> AnyPublisher<Double, Error>
    func getFixedDepositedData() -> AnyPublisher<Double, Error>
    func getDigitalData() -> AnyPublisher<Double, Error>
}

protocol HomeBalanceRepository {
    func getHomeBalance() -> AnyPublisher<Double, Error>
}

// Published, vế trái là Double, vế phải Error

//1. Saving: https://willywu0201.github.io/data/usdSavings1.json
//2. Fixed deposited: https://willywu0201.github.io/data/usdFixed1.json
//3. Digital: https://willywu0201.github.io/data/usdDigital1.json

class USDHomeBalanceRepository: HomeBalanceRepository, BalanceRepository {
    
    // First refresh == 1.json
    // Next refresh == 2.json
    // Chỉ dùng cho trường hợp này, thực tế không xảy ra.
    private var counter = 1
    
    func getHomeBalance() -> AnyPublisher<Double, Error> {
        Publishers.Zip3(getSavingData(), getDigitalData(), getFixedDepositedData())
            .map { (saving, digital, deposit) -> Double in
                saving + digital + deposit
            }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.counter = 2
            })
            .eraseToAnyPublisher()
    }
    
    func getSavingData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/usdSavings\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.savingsList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
    func getFixedDepositedData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/usdFixed\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.fixedDepositList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
    func getDigitalData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/usdDigital\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.digitalList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
}

class KHRHomeBalanceRepository: HomeBalanceRepository, BalanceRepository {
    
    private var counter = 1
    
    func getHomeBalance() -> AnyPublisher<Double, Error> {
        Publishers.Zip3(getSavingData(), getDigitalData(), getFixedDepositedData())
            .map { (saving, digital, deposit) -> Double in
                saving + digital + deposit
            }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.counter = 2
            })
            .eraseToAnyPublisher()
    }
    
    func getSavingData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/khrSavings\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.savingsList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
    func getFixedDepositedData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/khrFixed\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.fixedDepositList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
    func getDigitalData() -> AnyPublisher<Double, Error> {
        let url = URL(string: "https://willywu0201.github.io/data/khrDigital\(counter).json")!
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: BalanceResponseModel.self, decoder: JSONDecoder())
                .map { $0.result.digitalList?.first?.balance ?? 0.0}
                .eraseToAnyPublisher()
    }
    
}



