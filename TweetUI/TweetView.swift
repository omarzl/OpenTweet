//
//  TweetView.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI
import TweetFoundation

/// Shared UI for any tweet
public struct TweetView: View {
    
    private let tweet: Tweet

    /// Initializes the view
    /// - Parameter tweet: Tweet to be presented
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

// MARK: - Internal UI methods

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
                    avatarPlaceholder()
                })
            .frame(maxHeight: .infinity, alignment: .top)
        } else {
            avatarPlaceholder()
        }
    }
    
    @ViewBuilder
    func avatarPlaceholder() -> some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 40, height: 40)
            .frame(maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func authorViewFor(tweet: Tweet) -> some View {
        Text(tweet.name)
            .font(.otCaption)
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
            .font(.otCaption2)
            .lineLimit(1)
        
        Spacer()
    }
    
    @ViewBuilder
    func contentViewFor(tweet: Tweet) -> some View {
        
        Text(.init(tweet.content.replaceURL().replaceHandle()))
            .font(.otBody)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
            .frame(height: 3)
        
        HStack {
            Text(OTDateFormatter.relative.localizedString(for: tweet.date, relativeTo: Date.now))
                .font(.otCaption2)
            
            Spacer()
            
            generateIconAndText(named: "message")
            generateIconAndText(named: "heart")
            generateIconAndText(named: "bookmark")
        }
    }
    
    @ViewBuilder
    func generateIconAndText(named: String) -> some View {
        HStack {
            Image(systemName: named)
                .renderingMode(.template)
                .foregroundColor(.gray)
            
            Text("\(isTesting ? 100 : Int.random(in: 0..<1000))")
                .font(.otCaption2)
        }
    }
}
