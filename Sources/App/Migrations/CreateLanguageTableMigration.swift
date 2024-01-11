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
        database.schema("")
    }
    
    func revert(on database: Database) async throws {
        
    }
}
