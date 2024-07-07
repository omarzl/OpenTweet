//
//  TweetTimelineFeature.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI
import TweetTimelineFeatureInterface

public struct TweetTimelineFeature: TweetTimelineFeatureInterface {
    
    public init() {}
    
    public func view() -> some View {
        TweetTimelineView()
    }
}
