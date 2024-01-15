//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 09/01/24.
//

import Foundation
import Vapor

extension LanguageResponseDTO: Content {
    init?(languageModel: LanguageModel) {
        guard let id = languageModel.id else {
            return nil
        }
        
        self.init(id: id, name: languageModel.name ?? "")
    }
}
