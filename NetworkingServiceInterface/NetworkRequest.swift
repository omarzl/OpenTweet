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
    
    public var wrappedValue: AnyPublisher<Model, any Error> {
        get {
            Future { future in
                @Inject
                var service: Networking?
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
            .eraseToAnyPublisher()
        }
    }
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
}
