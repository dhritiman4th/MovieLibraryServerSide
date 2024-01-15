//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import Vapor
import Fluent

final class UserModel: Model, Content, Validatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init(){}
    
    init(id: UUID, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty, customFailureDescription: "Username should not be empty!!!")
        validations.add("password", as: String.self, is: !.empty, customFailureDescription: "Password should not be empty!!!")
        validations.add("password", as: String.self, is: .count(6...12), customFailureDescription: "Password length should be between 6 to 12!!!")
    }
}
