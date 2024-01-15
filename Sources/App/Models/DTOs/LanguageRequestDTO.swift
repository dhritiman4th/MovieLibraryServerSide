//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 09/01/24.
//

import Foundation
import Vapor

struct LanguageRequestDTO: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
