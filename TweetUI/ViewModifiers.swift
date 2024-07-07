//
//  ViewModifiers.swift
//  TweetUI
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import SwiftUI

/// Base modifier for a `List` view
public struct ListModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear.edgesIgnoringSafeArea(.all))
    }
    
    public init() {}
}

/// Base modifier for the separators of a `List` view
public struct SeparatorModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .listRowSeparatorTint(.blue, edges: .all)
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
    public init() {}
}
