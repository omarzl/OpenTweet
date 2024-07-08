//
//  Inject.swift
//  InjectionService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation

/// Wraps resolving a protocol using a property wrapper
///
/// Usage:
/// ```
/// @Inject
/// var object: SomeType?
/// ```
@propertyWrapper public struct Inject<Registrable> {
    /// The type of the object to which it should be resolved
    public var wrappedValue: Registrable? {
        InjectionServiceImpl.instance.resolve(registrable: Registrable.self)
    }
    
    public init() {}
}
