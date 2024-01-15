//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 08/01/24.
//

import Foundation
import Fluent

struct CreateLanguageTableMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("languages")
            .id()
            .field("name", .string, .required).unique(on: "name","userId")
            .field("userId", .uuid, .required, .references("users", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("languages")
            .delete()
    }
}
