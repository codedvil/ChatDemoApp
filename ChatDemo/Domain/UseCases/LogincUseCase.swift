//
//  LogincUseCase.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

struct LogincUseCase {
  private let repository: AuthRepositoryProtocol

  init(repository: AuthRepositoryProtocol) {
    self.repository = repository
  }

  func execute(email: String, password: String) async throws -> UserEntity {
    return try await repository.login(withEmail: email, password: password)
  }
}
