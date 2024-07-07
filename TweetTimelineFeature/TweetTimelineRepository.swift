//
//  TweetTimelineRepository.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Combine
import TweetFoundation
import NetworkingServiceInterface

final class TweetTimelineRepository {
    
    @NetworkRequest(url: "\(Endpoint.base)/opentweet")
    var request: AnyPublisher<Timeline, any Error>
    private var cancellables = Set<AnyCancellable>()
    
    func loadData() {
        request.sink { result in
            if case let .failure(error) = result {
                print(error)
            }
        } receiveValue: { value in
            print(value)
        }
        .store(in: &cancellables)
    }
}
