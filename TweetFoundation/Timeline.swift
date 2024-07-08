//
//  Timeline.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import SwiftData

/// Representation a timeline of tweets
final public class Timeline: Codable {
    /// The tweets list of a timeline
    public let tweets: [Tweet]
    
    enum CodingKeys: String, CodingKey {
        case tweets = "timeline"
    }
    
    public init(tweets: [Tweet]) {
        self.tweets = tweets
    }
}
