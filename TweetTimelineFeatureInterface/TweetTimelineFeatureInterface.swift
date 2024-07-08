//
//  TweetTimelineFeatureInterface.swift
//  TweetTimelineFeatureInterface
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI

public protocol TweetTimelineFeatureInterface {
    associatedtype ViewType: View
    func view() -> ViewType
}
