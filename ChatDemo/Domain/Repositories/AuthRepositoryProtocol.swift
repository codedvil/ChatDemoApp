//
//  AuthRepositoryProtocol.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation

protocol AuthRepositoryProtocol {
  func login(withEmail email: String, password: String) async throws -> UserEntity
  func signUp(withEmail email: String, password: String) async throws -> UserEntity
  func checkActiveSession() -> UserEntity?
}
