//
//  TweetTimelineViewModel.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

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
            timeline.tweets.forEach {
                modelContainer?.container.mainContext.insert($0)
            }
        }
    }
    
    @MainActor
    func loadTweets() async {
        guard let modelContainer else { return }
        do {
            tweets = try modelContainer.container.mainContext.fetch(FetchDescriptor<Tweet>())
        } catch {
        }
    }
}
