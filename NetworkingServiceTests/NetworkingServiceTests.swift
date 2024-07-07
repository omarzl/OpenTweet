//
//  NetworkingServiceTests.swift
//  NetworkingServiceTests
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import XCTest
import Combine
@testable import NetworkingService
import NetworkingServiceInterface
import InjectionService

final class NetworkingServiceTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        InjectionServiceImpl.instance.cleanAll()
    }

    func testGetRequest() async throws {
        // given
        let mock = ModelMock()
        let service = NetworkingServiceImpl(requester: NetworkingRequesterMock(mock: mock))
        // when
        let response: ModelMock = try await service.get(from: "https://mock.com")
        // then
        XCTAssertEqual(mock.msg, response.msg)
    }
    
    func testNetworkingErrors() async {
        // given
        let service = NetworkingServiceImpl(requester: NetworkingRequesterMock(mock: ModelMock()))
        do {
            // when
            let _: ModelMock = try await service.get(from: "")
            XCTAssert(false, "Expected an error")
        } catch {
            // then
            XCTAssertNotNil(error as? NetworkingError)
        }
    }
    
    func testPropertyWrapperExpectError() {
        // given
        var expectedError: Error?
        @NetworkRequest(url: "")
        var request: AnyPublisher<ModelMock, any Error>
        // when
        request.sink { completion in
            switch completion {
            case .finished:
                XCTAssert(false, "Expected an error")
            case .failure(let error):
                expectedError = error
            }
        } receiveValue: { _ in }
            .store(in: &cancellables)
        // then
        XCTAssertNotNil(expectedError as? InjectionError)
    }
    
    func testPropertyWrapperExpectSuccess() {
        // given
        let expectation = expectation(description: "Expected a result")
        var finishedCall = false
        InjectionServiceImpl.instance.register(registrable: Networking.self) {
            NetworkingServiceImpl(requester: NetworkingRequesterMock(mock: ModelMock()))
        }
        @NetworkRequest(url: "https://mock.com")
        var request: AnyPublisher<ModelMock, any Error>
        // when
        request.sink { completion in
            switch completion {
            case .finished:
                finishedCall = true
            case .failure(let error):
                XCTAssert(false, "Expected no error: \(error)")
            }
        expectation.fulfill()
        } receiveValue: { _ in }
            .store(in: &cancellables)
        // then
        waitForExpectations(timeout: 0.1)
        XCTAssert(finishedCall)
    }
}

struct ModelMock: Codable {
    var msg = "hello"
}
