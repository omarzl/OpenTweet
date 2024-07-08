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
            
            if !tweet.replies.isEmpty {
                Text("Replies")
                    .font(.footnote)
            }
            
            ForEach(tweet.replies) { tweet in
                ZStack {
                    NavigationLink {
                        TweetThreadView(tweet: tweet)
                    } label: {
                        EmptyView()
                    }.opacity(0.0)
                    TweetView(tweet: tweet)
                }
            }
            .modifier(SeparatorModifier())
            
            footLabel
        }
        .modifier(ListModifier())
        .navigationTitle(tweet.author)
    }
    
    
    @ViewBuilder
    var footLabel: some View {
        if tweet.replies.isEmpty {
            Text("No replies.")
                .font(.caption)
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
        }
    }
}
