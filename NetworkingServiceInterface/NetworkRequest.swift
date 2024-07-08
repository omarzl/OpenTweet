//
//  NetworkRequest.swift
//  NetworkingServiceInterface
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation
import Combine
import InjectionService

/// Wraps a network request
///
/// Usage:
/// ```
/// @NetworkRequest(url: "")
/// var request: AnyPublisher<Model, any Error>
/// ```
@propertyWrapper public struct NetworkRequest<Model: Decodable> {
    
    // MARK: - Public properties
    
    public var wrappedValue: AnyPublisher<Model, any Error> {
        Deferred {
            Future { future in
                @Inject
                var service: (any Networking)?
                guard let service else {
                    future(.failure(InjectionError.unregistered(type: Networking.self)))
                    return
                }
                Task {
                    do {
                        let model: Model = try await service.get(from: url)
                        future(.success(model))
                    } catch {
                        future(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Private properties
    
    private let url: String
    
    // MARK: - Init
    
    /// Initializes the property wrapper
    /// - Parameter url: URL to be requested
    public init(url: String) {
        self.url = url
    }
}
