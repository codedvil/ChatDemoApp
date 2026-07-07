//
//  FirebaseAuthRepository.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import FirebaseAuth

class FirebaseAuthRepository: AuthRepositoryProtocol {
  func login(withEmail email: String, password: String) async throws -> UserEntity {
    let result = try await Auth.auth().signIn(withEmail: email, password: password)

    return UserEntity(id: result.user.uid, email: result.user.email ?? "")
  }

  func signUp(withEmail email: String, password: String) async throws -> UserEntity {
    let result = try await Auth.auth().createUser(withEmail: email, password: password)
    return UserEntity(id: result.user.uid, email: result.user.email ?? "")
  }

  func checkActiveSession() -> UserEntity? {
    if let user = Auth.auth().currentUser {
      return UserEntity(id: user.uid, email: user.email ?? "")
    }

    return nil
  }
}
