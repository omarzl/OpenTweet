//
//  OTDateFormatter.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation

/// Base Date formatters
enum OTDateFormatter {
    /// Creates a date formatter that presents a time internal
    static var relative: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }
}
