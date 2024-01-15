//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 12/01/24.
//

import Foundation
import Vapor

struct MovieRequestDTO: Codable {
    let title: String
    let genre: String
    let releaseDate: String
    
    init(title: String, genre: String, releaseDate: String) {
        self.title = title
        self.genre = genre
        self.releaseDate = releaseDate
    }
}
