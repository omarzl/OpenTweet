//
//  NetworkError.swift
//  NetworkingService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation

/// Error types for Networking requests
public enum NetworkingError: Error {
    /// Used when the URL can't be parsed
    case wrongUrl(url: String)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongUrl(let url):
            "Wrong url: \(url)"
        }
    }
}
