//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Vapor

class UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // /api
        let api = routes.grouped("api")
        
        // /api/register
        api.post("register", use: registerUser)
        
        // /api/login
        api.post("login", use: loginUser)
    }
    
    func registerUser(req: Request) async throws -> String {
        return ""
    }
    
    func loginUser(req: Request) async throws -> String {
        return ""
    }
}
