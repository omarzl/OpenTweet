//
//  Timeline.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import SwiftData

/// Representation a timeline of tweets
final public class Timeline: Decodable {
    
    public let tweets: [Tweet]
    
    enum CodingKeys: String, CodingKey {
        case tweets = "timeline"
    }
}
