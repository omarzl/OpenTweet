//
//  StringExtension.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation

extension String {
    func replaceURL() -> String {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return self
        }
        var text = self
        let matches = detector.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        
        for match in matches {
            guard let range = Range(match.range, in: text) else { continue }
            let url = text[range]
            text.replaceSubrange(range, with: "[\(url)](\(url))")
        }
        return text
    }
    
    func replaceHandle() -> String {
        split(separator: " ")
            .map {
                if $0.starts(with: "@") {
                    return "**\($0)**"
                }
                return String($0)
            }
            .joined(separator: " ")
    }
}
