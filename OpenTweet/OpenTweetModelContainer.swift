//
//  OpenTweetModelContainer.swift
//  OpenTweet
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftData
import TweetFoundation

/// Wraps the SwiftData model container
final class OpenTweetModelContainer: OTModelContainer {
    
    static let shared = OpenTweetModelContainer()
    
    let container: ModelContainer = {
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
    
    private init() {}
}
