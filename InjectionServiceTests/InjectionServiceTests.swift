//
//  InjectionServiceTests.swift
//  InjectionServiceTests
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import XCTest
@testable import InjectionService

final class InjectionServiceTests: XCTestCase {

    func testResolvingProtocolExpectsSuccess() {
        // given
        let service = InjectionServiceImpl.instance
        // when
        service.register(registrable: ProtocolMock.self) { Mock() }
        let resolved = service.resolve(registrable: ProtocolMock.self)
        // then
        XCTAssertNotNil(resolved as? Mock)
    }
    
    func testResolvingUsingPropertyWrapperExectSuccess() {
        // given
        let service = InjectionServiceImpl.instance
        // when
        service.register(registrable: ProtocolMock.self) { Mock() }
        @Inject
        var resolved: ProtocolMock?
        // then
        XCTAssertNotNil(resolved as? Mock)
    }
}

protocol ProtocolMock {}
struct Mock: ProtocolMock {}
