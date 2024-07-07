//
//  OpenTweetApp.swift
//  OpenTweet
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import SwiftUI
import SwiftData
import InjectionService
import TweetTimelineFeatureInterface

@main
struct OpenTweetApp: App {
    
    @Inject
    private var timelineFeature: (any TweetTimelineFeatureInterface)?
    private let modelContainer = OpenTweetModelContainer()
    
    init() {
        Registrables().register()
    }

    var body: some Scene {
        WindowGroup {
            if let view = timelineFeature?.view() {
                AnyView(view)
            }
        }
        .modelContainer(modelContainer.container)
    }
}
