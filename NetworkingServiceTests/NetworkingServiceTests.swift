//
//  NetworkingServiceTests.swift
//  NetworkingServiceTests
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import XCTest
@testable import NetworkingService

final class NetworkingServiceTests: XCTestCase {

    func testGetRequest() async throws {
        // given
        let mock = ModelMock()
        let service = NetworkService(requester: NetworkingRequesterMock(mock: mock))
        // when
        let response: ModelMock = try await service.get(from: "https://mock.com")
        // then
        XCTAssertEqual(mock.msg, response.msg)
    }
    
    func testNetworkingErrors() async {
        // given
        let service = NetworkService(requester: NetworkingRequesterMock(mock: ModelMock()))
        do {
            // when
            let response: ModelMock = try await service.get(from: "")
            XCTAssert(false, "Expected an error")
        } catch {
            // then
            XCTAssertNotNil(error as? NetworkingError)
        }
    }
}

struct ModelMock: Codable {
    var msg = "hello"
}
