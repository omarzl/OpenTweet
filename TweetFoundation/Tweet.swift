//
//  TweetFoundation.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import SwiftData

/// Representation of a tweet
@Model
final public class Tweet: Decodable {
    /// Unique identifier
    @Attribute(.unique)
    public let id: String
    /// Author handle
    public let author: String
    /// Content of the tweet
    public let content: String
    /// Avatar image of the author
    public let avatar: String?
    /// Date when the tweet was published, in the format ISO-8601
    public let date: String
    /// Replies from other users to this tweet
    public var replies = [Tweet]()
    /// The parent tweet if it is a reply
    @Relationship(inverse: \Tweet.replies)
    public var parent: Tweet?
    /// The tweet ID to which it is replying
    @Transient
    public var inReplyTo: String?
    
    enum CodingKeys: CodingKey {
        case id, author, content, avatar, date, inReplyTo
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        content = try container.decode(String.self, forKey: .content)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        date = try container.decode(String.self, forKey: .date)
        inReplyTo = try container.decodeIfPresent(String.self, forKey: .inReplyTo)
    }
}
