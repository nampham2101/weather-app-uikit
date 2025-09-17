//
//  NetworkManager.swift
//  weather app uikit
//
//  Created by Nam Pham on 17/9/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(_ url: URL, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.unknown
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw ApiError.decoding(error)
                }
            case 401:
                throw ApiError.unauthorized
            case 400...499:
                let message = String(data: data, encoding: .utf8) ?? "Client error"
                throw ApiError.server(statusCode: httpResponse.statusCode, message: message)
            case 500...599:
                throw ApiError.server(statusCode: httpResponse.statusCode, message: "Server error")
            default:
                throw ApiError.unknown
            }
        } catch {
            throw ApiError.network(error)
        }
    }
    
    func getErrorMessage(_ error: ApiError) -> String {
        switch error {
        case .network:
            return "Please check your internet connection"
        case .decoding:
            return "Something went wrong with the data."
        case .unauthorized:
            return "Your session expired. Please log in again."
        case .server(_, let message):
            return "Server error: \(message)"
        case .unknown:
            return "Unknow error occurred."
        }
    }
}
