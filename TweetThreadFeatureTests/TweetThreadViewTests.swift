//
//  TweetThreadViewTests.swift
//  TweetThreadFeatureTests
//
//  Created by Omar Zúñiga Lagunas on 08/07/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
import Mocks
import InjectionService
import TweetFoundation
@testable import TweetThreadFeature

final class TweetThreadFeatureTests: XCTestCase {
    
    private var containerMock = ModelContainerMock()
    
    override func setUp() {
        super.setUp()
        containerMock = ModelContainerMock()
        let containerMock = containerMock
        InjectionServiceImpl.instance.register(registrable: (any OTModelContainer).self) {
            containerMock
        }
    }
    
    @MainActor
    func testView() {
        // given
        let reply = Tweet(id: "2", name: "Example", author: "test", content: "sdfsdf",
                          avatar: nil, date: Date(timeIntervalSince1970: 0), replies: [])
        containerMock.container.mainContext.insert(reply)
        
        let tweet = Tweet(id: "1", name: "Michael Scott", author: "test", content: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                """, avatar: nil, date: Date(timeIntervalSince1970: 0), replies: [
                    reply
                ])
        containerMock.container.mainContext.insert(tweet)
        
        let view = TweetThreadView(tweet: tweet)
        // then
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone12)))
    }
}
