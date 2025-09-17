//
//  ApiError.swift
//  weather app uikit
//
//  Created by Nam Pham on 17/9/25.
//

enum ApiError: Error {
    case network(Error)
    case decoding(Error)
    case server(statusCode: Int, message: String)
    case unauthorized
    case unknown
}
