//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Vapor

struct LoginResponseDTO: Codable {
    var uid: UUID? = nil
    var token: String? = nil
    let error: Bool
    var reason: String? = nil
    var name: String? = nil
    
    init(uid: UUID? = nil, token: String? = nil, error: Bool, reason: String? = nil, name: String? = nil) {
        self.uid = uid
        self.token = token
        self.error = error
        self.reason = reason
        self.name = name
    }
}
