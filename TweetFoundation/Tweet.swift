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
final public class Tweet: Codable {
    /// Unique identifier
    @Attribute(.unique)
    public let id: String
    /// Author handle
    public var name = Random.randomFakeName()
    /// Author handle
    public let author: String
    /// Content of the tweet
    public let content: String
    /// Avatar image of the author
    public let avatar: String?
    /// Date when the tweet was published, in the format ISO-8601
    public let date: Date
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
    
    public init(
        id: String,
        author: String,
        content: String,
        avatar: String?,
        date: Date,
        replies: [Tweet]
    ) {
        self.id = id
        self.author = author
        self.content = content
        self.avatar = avatar
        self.date = date
        self.replies = replies
        self.name = name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        content = try container.decode(String.self, forKey: .content)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        let dateString = try container.decode(String.self, forKey: .date)
        date = Tweet.dateFormatter.date(from: dateString) ?? Date()
        inReplyTo = try container.decodeIfPresent(String.self, forKey: .inReplyTo)
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(content, forKey: .content)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(Tweet.dateFormatter.string(from: date), forKey: .date)
        try container.encode(inReplyTo, forKey: .inReplyTo)
    }
}

extension Tweet {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
}
