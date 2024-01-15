//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 12/01/24.
//

import Foundation
import Fluent

struct CreateMovieTableMigration: AsyncMigration {
    private let schema = "movies"
    
    func prepare(on database: FluentKit.Database) async throws {
        try await database.schema(schema)
            .id()
            .field("title", .string, .required)
            .field("releaseDate", .string, .required)
            .field("genre", .string, .required).unique(on: "title", "languageId")
            .field("languageId", .uuid, .references("languages", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema(schema)
            .delete()
    }
}
