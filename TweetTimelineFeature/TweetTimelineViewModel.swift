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
    
    init() {
        loadTweets()
    }
    
    func refresh() {
        request.sink { result in
            if case let .failure(error) = result {
                print(error)
            }
        } receiveValue: { [weak self] timeline in
            self?.save(timeline: timeline)
            self?.loadTweets()
        }
        .store(in: &cancellables)
    }
}

private extension TweetTimelineViewModel {
    func save(timeline: Timeline) {
        Task { @MainActor in
            timeline.tweets.forEach {
                modelContainer?.container.mainContext.insert($0)
            }
        }
    }
    
    func loadTweets() {
        guard let modelContainer else { return }
        Task { @MainActor in
            do {
                tweets = try modelContainer.container.mainContext.fetch(FetchDescriptor<Tweet>())
            } catch {
            }
        }
    }
}
