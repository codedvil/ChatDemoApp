//
//  ProfileUseCases.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation

struct GetProfileUseCase {
  private let repository: ProfileRepositoryProtocol

  init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }

  func execute(userId: String) async throws -> UserProfileEntity {
    return try await repository.fetchProfile(userId: userId)
  }
}

struct SaveProfileUseCase {
  private let repository: ProfileRepositoryProtocol

  init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }

  func execute(profile: UserProfileEntity) async throws {
    try await repository.saveProfile(profile: profile)
  }
}
