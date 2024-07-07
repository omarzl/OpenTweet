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
import TweetFoundation

@main
struct OpenTweetApp: App {
    
    @Inject
    var timelineFeature: (any TweetTimelineFeatureInterface)?
    
    init() {
        Registrables().register()
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tweet.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            if let view = timelineFeature?.view() {
                AnyView(view)
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
