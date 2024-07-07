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
        NavigationView {
            List {
                ForEach(viewModel.tweets) { tweet in
                    VStack {
                        HStack() {
                            avatarViewFor(tweet: tweet)
                            VStack {
                                HStack {
                                    authorViewFor(tweet: tweet)
                                }
                                contentViewFor(tweet: tweet)
                            }
                        }
                    }
                }
                .listRowSeparatorTint(.blue, edges: .all)
                .frame( maxWidth: .infinity)
                .edgesIgnoringSafeArea(.horizontal)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear.edgesIgnoringSafeArea(.all))
            .navigationTitle("OpenTweet")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
    
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
        Text(tweet.content)
            .font(.body)
    }
}
