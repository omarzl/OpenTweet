//
//  TweetThreadFeatureInterface.swift
//  TweetThreadFeatureInterface
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI
import TweetFoundation

public protocol TweetThreadFeatureInterface {
    associatedtype V: View
    func viewFor(tweet: Tweet) -> V
}
