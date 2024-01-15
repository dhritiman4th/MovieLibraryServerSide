//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 12/01/24.
//

import Foundation
import Vapor
import Fluent

struct MovieController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // /api/languages/<languageId>
        let api = routes.grouped("api", "users", ":userId", "languages",":languageId").grouped(JSONWebTokenAuthenticator())
        
        // /api/users/<userId>/languages/<languageId>/movies
        api.get("movies", use: fetchMovies)
        
        // /api/users/<userId>/languages/<languageId>/movies
        api.post("movies", use: addMovie)
    }
    
    func fetchMovies(req: Request) async throws -> [MovieResponseDTO] {
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let languageId = req.parameters.get("languageId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let _ = try await LanguageModel.query(on: req.db)
            .filter(\.$user.$id == userId)
            .first() else {
            return []
        }
        
        let movies = try await MovieModel.query(on: req.db)
            .filter(\.$language.$id == languageId)
            .all()
            .compactMap(MovieResponseDTO.init)
        
        return movies
    }
    
    func addMovie(req: Request) async throws -> MovieResponseDTO {
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let languageId = req.parameters.get("languageId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let _ = try await UserModel.find(userId, on: req.db) else {
            throw Abort(.notFound)
        }
        guard let _ = try await LanguageModel.find(languageId, on: req.db) else {
            throw Abort(.notFound)
        }
        let movieRequestDTO = try req.content.decode(MovieRequestDTO.self)
        
        let movieModel = MovieModel(title: movieRequestDTO.title,
                                    genre: movieRequestDTO.genre,
                                    releaseDate: movieRequestDTO.releaseDate,
                                    languageId: languageId)
        do {
            try await movieModel.save(on: req.db)
        } catch {
            print(error.localizedDescription)
            throw Abort(.internalServerError)
        }
        
        guard let movieResponseDTO = MovieResponseDTO(movieModel: movieModel) else {
            throw Abort(.internalServerError)
        }
        return movieResponseDTO
    }
    
    func deleteMovie(req: Request) async throws -> MovieResponseDTO {
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let languageId = req.parameters.get("languageId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let _ = try await UserModel.find(userId, on: req.db) else {
            throw Abort(.notFound)
        }
        guard let movieToBeDeleted = try await MovieModel.query(on: req.db)
            .filter(\.$language.$id == languageId)
            .first() else {
            throw Abort(.notFound)
        }
        
        try await movieToBeDeleted.delete(on: req.db)
        
        guard let deletedMovie = MovieResponseDTO(movieModel: movieToBeDeleted) else {
            throw Abort(.internalServerError)
        }
        return deletedMovie
    }
}
