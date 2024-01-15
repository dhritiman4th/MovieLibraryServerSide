//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 12/01/24.
//

import Foundation
import Vapor

extension MovieResponseDTO: Content {
    init?(movieModel: MovieModel) {
        guard let id = movieModel.id else {
            return nil
        }
        self.init(id: id, title: movieModel.title, genre: movieModel.genre, releaseDate: movieModel.releaseDate)
    }
}
