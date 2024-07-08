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
import TweetUI

struct Registrables {
    func register() {
        if isTesting { return }
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
