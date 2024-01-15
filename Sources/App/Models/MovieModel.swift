//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 08/01/24.
//

import Foundation
import Vapor
import Fluent

final class MovieModel: Content, Model, Validatable {
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String?
    
    @Field(key: "genre")
    var genre: String?
    
    @Field(key: "releaseDate")
    var releaseDate: String?
    
    @Parent(key: "languageId")
    var language: LanguageModel
    
    init(){}
    
    init(id: UUID? = nil, title: String, genre: String, releaseDate: String, languageId: UUID) {
        self.id = id
        self.title = title
        self.genre = genre
        self.releaseDate = releaseDate
        self.$language.id = languageId
    }
    
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "Title should not be empty!!!")
        validations.add("genre", as: String.self, is: !.empty, customFailureDescription: "Release date should not be empty!!!")
        validations.add("releaseDate", as: String.self, is: !.empty, customFailureDescription: "Release year should not be empty!!!" )
    }
}
