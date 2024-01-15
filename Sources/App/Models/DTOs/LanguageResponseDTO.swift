//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 09/01/24.
//

import Foundation

struct LanguageResponseDTO: Codable {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
