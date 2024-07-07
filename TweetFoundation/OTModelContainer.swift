//
//  OTModelContainer.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftData

/// Access to the shared model container
public protocol OTModelContainer {
    /// The raw container
    var container: ModelContainer { get }
}
