//
//  TweetTimelineView.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftData
import SwiftUI
import TweetFoundation
import TweetUI

struct TweetTimelineView: View {
    
    @StateObject
    private var viewModel = TweetTimelineViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tweets) { tweet in
                    TweetView(tweet: tweet)
                }
                .modifier(SeparatorModifier())
                
                footLabel
            }
            .modifier(ListModifier())
            .navigationTitle("OpenTweet")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
    
    @ViewBuilder
    var footLabel: some View {
        Text(viewModel.tweets.isEmpty ? "Loading..." : "You are up to date!")
            .font(.caption)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
    }
}
