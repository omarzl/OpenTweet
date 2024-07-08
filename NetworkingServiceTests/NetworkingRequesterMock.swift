//
//  NetworkingRequesterMock.swift
//  NetworkingServiceTests
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation
@testable import NetworkingService

struct NetworkingRequesterMock: NetworkingRequesting {
    
    let mock: Codable
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        (
            try JSONEncoder().encode(mock),
            URLResponse(url: URL(filePath: ""), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        )
    }
}
