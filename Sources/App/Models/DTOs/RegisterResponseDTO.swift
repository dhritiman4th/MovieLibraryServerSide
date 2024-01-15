//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
    
    init(error: Bool, reason: String? = nil) {
        self.error = error
        self.reason = reason
    }
}
