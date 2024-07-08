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
import TweetThreadFeatureInterface
import InjectionService

/// Main view that shows a timeline of tweets
struct TweetTimelineView: View {
    
    @StateObject
    private var viewModel = TweetTimelineViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tweets) { tweet in
                    ZStack {
                        NavigationLink {
                            @Inject
                            var threadFeature: (any TweetThreadFeatureInterface)?
                            if let threadFeature {
                                AnyView(threadFeature.viewFor(tweet: tweet))
                            }
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
            .navigationTitle("OpenTweet")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
    
    @ViewBuilder
    var footLabel: some View {
        Text(viewModel.tweets.isEmpty ? "Loading..." : "You are up to date! 🎉")
            .font(.otCaption)
            .frame(maxWidth: .infinity)
            .listRowSeparator(.hidden)
    }
}
