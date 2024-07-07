//
//  RandomName.swift
//  TweetFoundation
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

// Taken from: https://github.com/thellimist/SwiftRandom/blob/master/SwiftRandom/Randoms.swift
// under the MIT license

import Foundation

/// Generates random data
enum Random {
    /// Creates a random name
    /// - Returns: A string with a random first and last name
    static func randomFakeName() -> String {
        return randomFakeFirstName() + " " + randomFakeLastName()
    }
    
    /// Creates a random first name
    /// - Returns: A string with a random first name
    static func randomFakeFirstName() -> String {
        let firstNameList = ["Henry", "William", "Geoffrey", "Jim", "Yvonne", "Jamie", "Leticia", "Priscilla", "Sidney", "Nancy", "Edmund", "Bill", "Megan"]
        return firstNameList.randomElement() ?? ""
    }
    
    /// Creates a random last name
    /// - Returns: A string with a random last name
    static func randomFakeLastName() -> String {
        let lastNameList = ["Pearson", "Adams", "Cole", "Francis", "Andrews", "Casey", "Gross", "Lane", "Thomas", "Patrick", "Strickland", "Nicolas", "Freeman"]
        return lastNameList.randomElement() ?? ""
    }
}
