//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Fluent

struct CreateUserTableMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users")
            .delete()
    }
}
