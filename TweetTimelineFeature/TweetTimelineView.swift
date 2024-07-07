//
//  TweetTimelineView.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftData
import SwiftUI
import TweetFoundation

struct TweetTimelineView: View {
    
    @StateObject
    private var viewModel = TweetTimelineViewModel()
    
    var body: some View {
        ForEach(viewModel.tweets) { tweet in
            Text(tweet.id + tweet.content)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}
