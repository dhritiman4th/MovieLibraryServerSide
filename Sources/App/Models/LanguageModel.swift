//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 08/01/24.
//

import Foundation
import Vapor
import Fluent

final class LanguageModel: Content, Validatable, Model {
    
    static let schema: String = "languages"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String?
    
    @Parent(key: "userId")
    var user: UserModel
    
    init() {
    }

    init(id: UUID? = nil, name: String, userId: UUID) {
        self.id = id
        self.name = name
        self.$user.id = userId
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("name", as: String.self, is: !.empty, customFailureDescription: "Language name should not be empty.")
    }
}
