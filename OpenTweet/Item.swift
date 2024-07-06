//
//  Item.swift
//  OpenTweet
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
