//
//  NetworkingRequesting.swift
//  NetworkingService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation

/// The implementar is the responsible of making the actual network request
public protocol NetworkingRequesting {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkingRequesting {}
