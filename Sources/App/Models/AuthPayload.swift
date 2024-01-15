//
//  File.swift
//  
//
//  Created by Dhritiman Saha on 03/01/24.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {
    typealias Payload = AuthPayload
    
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var userId: UUID
    
    enum CokingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case userId = "uid"
    }
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
