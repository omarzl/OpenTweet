//
//  RunningInfo.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 08/07/24.
//

import Foundation

public var isTesting: Bool {
    #if DEBUG
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    #else
    false
    #endif
}
