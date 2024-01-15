//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 08/01/24.
//

import Foundation
import Vapor
import Fluent

struct LanguageController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // /api
        let api = routes.grouped("api", "users", ":userId").grouped(JSONWebTokenAuthenticator())
        
        // /api/languages/
        api.post("languages", use: addlanguage)
        
        // /api/languages/
        api.get("languages", use: getLanguages)
    }
    
    func addlanguage(req: Request) async throws -> LanguageResponseDTO {
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let languageRequestDTO = try req.content.decode(LanguageRequestDTO.self)
        
        let languageModel = LanguageModel(name: languageRequestDTO.name, userId: userId)
        
        do {
            try await languageModel.save(on: req.db)
        } catch {
            print(error.localizedDescription)
            throw Abort(.internalServerError)
        }
        
        guard let languageResponseDTO = LanguageResponseDTO(languageModel: languageModel) else {
            throw Abort(.internalServerError)
        }
        
        return languageResponseDTO
    }
    
    func getLanguages(req: Request) async throws -> [LanguageResponseDTO] {
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let languages = try await LanguageModel.query(on: req.db)
            .filter(\.$user.$id == userId)
            .all()
            .compactMap(LanguageResponseDTO.init)
        return languages
    }
}
