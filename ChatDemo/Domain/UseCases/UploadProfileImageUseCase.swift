//
//  UploadProfileImageUseCase.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import UIKit

struct UploadProfileImageUseCase {
  private let repository: ProfileRepositoryProtocol

  init(repository: ProfileRepositoryProtocol) {
    self.repository = repository
  }

  func execute(userId: String, image: UIImage) async throws -> String {
    return try await repository.uploadProfileImage(userId: userId, image: image)
  }
}
