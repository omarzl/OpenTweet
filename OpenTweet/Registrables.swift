//
//  Registrables.swift
//  OpenTweet
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import InjectionService
import NetworkingService
import NetworkingServiceInterface
import TweetTimelineFeature
import TweetTimelineFeatureInterface
import TweetThreadFeature
import TweetThreadFeatureInterface
import TweetFoundation

struct Registrables {
    func register() {
        #if DEBUG
        // Prevents registering production registrables during tests
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return
        }
        #endif
        InjectionServiceImpl.instance.register(registrable: Networking.self) {
            NetworkingServiceImpl()
        }
        
        InjectionServiceImpl.instance.register(registrable: (any TweetTimelineFeatureInterface).self) {
            TweetTimelineFeature()
        }
        
        InjectionServiceImpl.instance.register(registrable: (any TweetThreadFeatureInterface).self) {
            TweetThreadFeature()
        }
        
        InjectionServiceImpl.instance.register(registrable: (any OTModelContainer).self) {
            OpenTweetModelContainer.shared
        }
    }
}
