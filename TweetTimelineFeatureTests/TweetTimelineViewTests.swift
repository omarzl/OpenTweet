//
//  TweetTimelineViewTests.swift
//  TweetTimelineFeatureTests
//
//  Created by Omar Zúñiga Lagunas on 08/07/24.
//

import XCTest
@testable import TweetTimelineFeature
import SnapshotTesting
import Mocks
import TweetFoundation
import InjectionService

import SwiftUI

final class TweetTimelineViewTests: XCTestCase {

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
    func testView() async {
        // given
        let viewModel = TweetTimelineViewModel()
        // when
        containerMock.container.mainContext.insert(
            Tweet(id: "1", name: "Michael Scott", author: "test", content: "hey",
                  avatar: nil, date: Date(timeIntervalSince1970: 0), replies: [])
        )
        containerMock.container.mainContext.insert(
            Tweet(id: "2", name: "Michael Scott", author: "test2", content: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit,
                  sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
                """, avatar: nil, date: Date(timeIntervalSince1970: 10), replies: [])
        )
        await viewModel.refresh()
        // then
        let view = TweetTimelineView(viewModel: viewModel).fixedSize()
        assertSnapshot(of: view, as: .image)
    }
}
