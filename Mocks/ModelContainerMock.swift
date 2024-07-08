//
//  ModelContainerMock.swift
//  Mocks
//
//  Created by Omar Zúñiga Lagunas on 08/07/24.
//

import SwiftData
import TweetFoundation

public final class ModelContainerMock: OTModelContainer {
        
    public let container: ModelContainer = {
        let schema = Schema([
            Tweet.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    public init() {}
}
