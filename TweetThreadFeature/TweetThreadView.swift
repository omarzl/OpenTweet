//
//  TweetThreadView.swift
//  TweetThreadFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftData
import SwiftUI
import TweetFoundation
import TweetUI

/// Main view that shows a tweet thread
struct TweetThreadView: View {
    
    private let tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
    var body: some View {
        List {
            TweetView(tweet: tweet)
                .modifier(SeparatorModifier())
            
            ForEach(tweet.replies) { tweet in
                TweetView(tweet: tweet)
            }
            .modifier(SeparatorModifier())
        }
        .modifier(ListModifier())
        .navigationTitle(tweet.author)
    }
}
