//
//  TweetTimelineViewModel.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import Combine
import SwiftData
import TweetFoundation
import NetworkingServiceInterface
import InjectionService
import OSLog

final class TweetTimelineViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published
    var tweets = [Tweet]()
    
    // MARK: - Private properties
    
    private var logger = Logger()
    private var cancellables = Set<AnyCancellable>()
    @NetworkRequest(url: "\(Endpoint.base)/opentweet")
    private var request: AnyPublisher<Timeline, any Error>
    @Inject
    private var modelContainer: OTModelContainer?
    
    /// Loads the data from the storage or from the API
    @MainActor
    func refresh() async {
        await loadTweets()
        // If they are saved, we are not getting them from the API
        guard tweets.isEmpty else { return }
        getTweets()
    }
}

private extension TweetTimelineViewModel {
    func getTweets() {
        request.sink { [weak self] result in
            if case let .failure(error) = result {
                self?.logger.error("Error requesting tweets: \(error)")
            }
        } receiveValue: { [weak self] timeline in
            guard let self else { return }
            Task {
                await self.save(timeline: timeline)
                await self.loadTweets()
            }
        }
        .store(in: &cancellables)
    }
    
    @MainActor
    func save(timeline: Timeline) {
        timeline.tweets.forEach { tweet in
            modelContainer?.container.mainContext.insert(tweet)
            if let parentID = tweet.inReplyTo {
                let descriptor = FetchDescriptor(predicate: #Predicate<Tweet> { $0.id == parentID })
                let parentTweet = try? modelContainer?.container.mainContext.fetch(descriptor).first
                parentTweet?.replies.append(tweet)
            }
        }
    }
    
    @MainActor
    func loadTweets() async {
        guard let modelContainer else { return logger.error("There is no model container") }
        do {
            let descriptor = FetchDescriptor(
                predicate: #Predicate<Tweet> { $0.parent == nil },
                sortBy: [SortDescriptor(\Tweet.date)]
            )
            tweets = try modelContainer.container.mainContext.fetch(descriptor)
        } catch {
            logger.error("Error loading tweets: \(error)")
        }
    }
}
