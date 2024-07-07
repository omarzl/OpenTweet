//
//  NetworkingService.swift
//  NetworkingService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation
import OSLog

/// Responsible of sending networking requests
final public class NetworkService {
    
    // MARK: - Private properties
    
    private let logger = Logger()
    private let requester: any NetworkingRequesting
    
    /// Initializes the Networking Service
    /// - Parameter requester: The responsible for making the actual requests
    public init(requester: some NetworkingRequesting = URLSession.shared) {
        self.requester = requester
    }
    
    // MARK: - Public methods
    
    /// Sends a GET request to the specified URL
    /// - Parameter url: Resource URL
    /// - Returns: The parsed Model's object
    public func get<Model: Decodable>(from url: String) async throws -> Model {
        guard let url = URL(string: url) else { throw NetworkingError.wrongUrl(url: url) }
        let request = URLRequest(url: url)
        let (data, _) = try await requester.data(for: request)
        let model = try JSONDecoder().decode(Model.self, from: data)
        logger.debug("[\(url)] response: \(String(describing: model))")
        return model
    }
}
