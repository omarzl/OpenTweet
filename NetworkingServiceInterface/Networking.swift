//
//  Networking.swift
//  NetworkingServiceInterface
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

public protocol Networking {
    func get<Model: Decodable>(from url: String) async throws -> Model
}
