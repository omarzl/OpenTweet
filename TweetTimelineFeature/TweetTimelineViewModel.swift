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

final class TweetTimelineViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published
    var tweets = [Tweet]()
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    @NetworkRequest(url: "\(Endpoint.base)/opentweet")
    private var request: AnyPublisher<Timeline, any Error>
    @Inject
    private var modelContainer: OTModelContainer?
    
    /// Loads the data from the storage or from the API
    func refresh() {
        Task { @MainActor in
            await loadTweets()
            // If they are saved, we are not getting them from the API
            guard tweets.isEmpty else { return }
            getTweets()
        }
    }
}

private extension TweetTimelineViewModel {
    func getTweets() {
        request.sink { result in
            if case let .failure(error) = result {
                print(error)
            }
        } receiveValue: { [weak self] timeline in
            guard let self else { return }
            self.save(timeline: timeline)
            Task {
                await self.loadTweets()
            }
        }
        .store(in: &cancellables)
    }
    
    func save(timeline: Timeline) {
        Task { @MainActor in
            timeline.tweets.forEach { tweet in
                modelContainer?.container.mainContext.insert(tweet)
                if let parentID = tweet.inReplyTo {
                    let descriptor = FetchDescriptor(predicate: #Predicate<Tweet> { $0.id == parentID })
                    let parentTweet = try? modelContainer?.container.mainContext.fetch(descriptor).first
                    parentTweet?.replies.append(tweet)
                }
            }
        }
    }
    
    @MainActor
    func loadTweets() async {
        guard let modelContainer else { return }
        do {
            let descriptor = FetchDescriptor(predicate: #Predicate<Tweet> { $0.parent == nil })
            tweets = try modelContainer.container.mainContext.fetch(descriptor)
        } catch {
        }
    }
}
