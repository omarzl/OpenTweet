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

struct Registrables {
    func register() {
        InjectionServiceImpl.instance.register(registrable: Networking.self) {
            NetworkingServiceImpl()
        }
        
        InjectionServiceImpl.instance.register(registrable: (any TweetTimelineFeatureInterface).self) {
            TweetTimelineFeature()
        }
    }
}
