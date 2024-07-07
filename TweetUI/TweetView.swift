//
//  TweetView.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI
import TweetFoundation

public struct TweetView: View {
    
    private let tweet: Tweet
    
    public init(tweet: Tweet) {
        self.tweet = tweet
    }

    public var body: some View {
        HStack(spacing: 10) {
            avatarViewFor(tweet: tweet)
            VStack {
                HStack(spacing: 2) {
                    authorViewFor(tweet: tweet)
                }
                contentViewFor(tweet: tweet)
            }
        }
    }
}

private extension TweetView {
    @ViewBuilder
    func avatarViewFor(tweet: Tweet) -> some View {
        if let avatar = tweet.avatar {
            AsyncImage(
                url: URL(string: avatar),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .clipped()
                },
                placeholder: {
                    Color.clear
                        .frame(width: 40, height: 40)
                })
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    @ViewBuilder
    func authorViewFor(tweet: Tweet) -> some View {
        Text(tweet.name)
            .font(.caption)
            .bold()
        
        AsyncImage(
            url: URL(string: "https://cdn-icons-png.flaticon.com/256/7641/7641727.png"),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            },
            placeholder: {
                Color.clear
                    .frame(width: 20, height: 20)
            })
        
        Text(tweet.author)
            .font(.caption2)
            .lineLimit(1)
        
        Spacer()
    }
    
    @ViewBuilder
    func contentViewFor(tweet: Tweet) -> some View {
        
        Text(.init(replaceURL(from: tweet.content)))
            .font(.body)
        
        Spacer()
            .frame(height: 3)
        
        HStack {
            Text(OTDateFormatter.relative.localizedString(for: tweet.date, relativeTo: Date.now))
                .font(.caption2)
            
            Spacer()
            
            generateIconAndText(named: "message")
            generateIconAndText(named: "heart")
            generateIconAndText(named: "bookmark")
        }
    }
    
    func replaceURL(from text: String) -> String {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return text }
        var text = text
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: text) else { continue }
            let url = text[range]
            text.replaceSubrange(range, with: "[\(url)](\(url))")
        }
        return text
    }
    
    @ViewBuilder
    func generateIconAndText(named: String) -> some View {
        HStack {
            Image(systemName: named)
                .renderingMode(.template)
                .foregroundColor(.gray)
            
            Text("\(Int.random(in: 0..<1000))")
                .font(.caption2)
        }
    }
}
