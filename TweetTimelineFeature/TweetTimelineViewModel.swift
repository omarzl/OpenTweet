//
//  TweetTimelineViewModel.swift
//  TweetTimelineFeature
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation

struct TweetTimelineViewModel {
    
    private let repository = TweetTimelineRepository()
    
    init() {
        repository.loadData()
    }
}
