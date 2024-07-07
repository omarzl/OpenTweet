//
//  TweetThreadFeature.swift
//  TweetThreadFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI
import TweetFoundation
import TweetThreadFeatureInterface

/// Feature entry point for a tweet thread
public struct TweetThreadFeature: TweetThreadFeatureInterface {
    
    public init() {}
    
    public func viewFor(tweet: Tweet) -> some View {
        TweetThreadView(tweet: tweet)
    }
}
