//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 10/01/24.
//

import Foundation
import Vapor
struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {
    func authenticate(request: Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }
}
