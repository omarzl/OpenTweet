//
//  TweetTimelineFeatureTests.swift
//  TweetTimelineFeatureTests
//
//  Created by Omar Zúñiga Lagunas on 08/07/24.
//

import XCTest
import Combine
import Mocks
import InjectionService
import TweetFoundation
import NetworkingService
import NetworkingServiceInterface
@testable import TweetTimelineFeature

final class TweetTimelineFeatureTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    private var containerMock = ModelContainerMock()
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        containerMock = ModelContainerMock()
        let containerMock = containerMock
        InjectionServiceImpl.instance.register(registrable: (any OTModelContainer).self) {
            containerMock
        }
    }
    
    override func tearDown() {
        super.tearDown()
        InjectionServiceImpl.instance.cleanAll()
    }
    
    func testTweetsLoadingExpectSuccess() {
        let expectation = expectation(description: "Tweets should be loaded")
        // given
        let tweet = Tweet(id: "1", name: "", author: "test", content: "hey", avatar: nil, date: .now, replies: [])
        let timeline = Timeline(tweets: [tweet])
        let viewModel = TweetTimelineViewModel()
        // when
        InjectionServiceImpl.instance.register(registrable: Networking.self) {
            NetworkingServiceImpl(requester: NetworkingRequesterMock(mock: timeline))
        }
        
        viewModel.$tweets.sink { tweets in
            if tweets.first?.id == tweet.id { expectation.fulfill() }
        }.store(in: &cancellables)
        
        Task {
            await viewModel.refresh()
        }
        // then
        waitForExpectations(timeout: 0.1)
    }
}
