//
//  InjectionService.swift
//  InjectionService
//
//  Created by Omar Zúñiga Lagunas on 06/07/24.
//

import Foundation

/// Responsible of managing the indirect registrable objects
public final class InjectionServiceImpl {
    
    // MARK: - Public properties
    /// Shared instance responsible of managing the registrable objects
    public static let instance = InjectionServiceImpl()
    
    // MARK: - Private properties
    
    private var registrables = [String: () -> Any]()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public methods
    
    /// Registers a factory closure to a protocol type
    /// - Parameters:
    ///   - registrable: The protocol type
    ///   - factory: The closure to be called when the protocol is resolved
    public func register<Registrable>(registrable: Registrable.Type, factory: @escaping () -> Registrable) {
        registrables[String(describing: registrable)] = factory
    }
    
    /// Resolves the object that conforms to the protocol type
    /// - Parameter registrable: The protocol type
    /// - Returns: The object of type `Registrable`
    public func resolve<Registrable>(registrable: Registrable.Type) -> Registrable? {
        registrables[String(describing: registrable)]?() as? Registrable
    }
    
    /// Cleans all registered protocols
    public func cleanAll() {
        registrables.removeAll()
    }
}
