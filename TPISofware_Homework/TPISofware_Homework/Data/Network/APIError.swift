//
//  APIError.swift
//  TPISofware_Homework
//
//  Created by vfa on 20/05/2024.
//

import Foundation

enum APIError: Error {
    case error(String)
       case errorURL
       case invalidResponse
       case errorParsing
       case unknown
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
          return string
        case .errorURL:
          return "URL String is error."
        case .invalidResponse:
          return "Invalid response"
        case .errorParsing:
          return "Failed parsing response from server"
        case .unknown:
          return "An unknown error occurred"
        }
      }
}
