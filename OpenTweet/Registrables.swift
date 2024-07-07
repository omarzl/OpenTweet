//
//  Registrables.swift
//  OpenTweet
//
//  Created by Omar Zúñiga Lagunas on 07/07/24.
//

import Foundation
import InjectionService
import NetworkingService
import NetworkingServiceInterface

struct Registrables {
    func register() {
        InjectionServiceImpl.instance.register(registrable: Networking.self) {
            NetworkingServiceImpl()
        }
    }
}
