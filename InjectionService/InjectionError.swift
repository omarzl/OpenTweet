//
//  InjectionError.swift
//  InjectionService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation

/// Error types tiggered when resolving a Registrable
public enum InjectionError: Error {
    /// Used when the protocol is not registed
    case unregistered(type: Any)
}
