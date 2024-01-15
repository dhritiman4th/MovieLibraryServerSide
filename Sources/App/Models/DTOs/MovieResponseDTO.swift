//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 12/01/24.
//

import Foundation
import Vapor

struct MovieResponseDTO: Codable {
    var id: UUID? = nil
    var title: String? = nil
    var genre: String? = nil
    var releaseDate: String? = nil
    
    init(id: UUID? = nil, title: String? = nil, genre: String? = nil, releaseDate: String? = nil) {
        self.id = id
        self.title = title
        self.genre = genre
        self.releaseDate = releaseDate
    }
}
