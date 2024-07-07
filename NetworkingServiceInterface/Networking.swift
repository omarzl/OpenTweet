//
//  Networking.swift
//  NetworkingServiceInterface
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

/// Abstraction of RESTful network requests
public protocol Networking {
    /// Calls an url with a GET request
    /// - Parameter url: URL to be called
    /// - Returns: Returns a parsed model of type `Decodable`
    func get<Model: Decodable>(from url: String) async throws -> Model
}
