//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Vapor
import Fluent

class UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        
        // /api
        let api = routes.grouped("api")
        
        // /api/register
        api.post("register", use: registerUser)
        
        // /api/login
        api.post("login", use: loginUser)
    }
    
    func registerUser(req: Request) async throws -> RegisterResponseDTO {
        try UserModel.validate(content: req)
        
        let user = try req.content.decode(UserModel.self)
        
        if let _ = try await UserModel.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username is already exists!!!")
        }
        
        // hash the password
        user.password = try req.password.hash(user.password)
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
    
    func loginUser(req: Request) async throws -> LoginResponseDTO {
        let user = try req.content.decode(UserModel.self)
        
        guard let existingUser = try await UserModel.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
            throw Abort(.notFound, reason: "username not found")
        }
        
        let isPasswordVerified = try await req.password.async.verify(user.password, created: existingUser.password)
        if !isPasswordVerified {
            return LoginResponseDTO(error: true, reason: "Please enter a valid password")
        }
        
        let authPayload = try AuthPayload(subject: .init(value: "Movie Library App"), expiration: .init(value: .distantFuture), userId: existingUser.requireID())
        
        return try LoginResponseDTO(
            uid: existingUser.requireID(),
            token: req.jwt.sign(authPayload),
            error: false,
            name: user.username)
    }
}
