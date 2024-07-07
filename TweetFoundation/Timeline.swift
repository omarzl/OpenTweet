//
//  Timeline.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import SwiftData

/// Representation a timeline of tweets
@Model
final public class Timeline: Decodable {
    
    let tweets: [Tweet]
    
    enum CodingKeys: String, CodingKey {
        case tweets = "timeline"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tweets = try container.decode([Tweet].self, forKey: .tweets)
    }
}
