//
//  AuthManager.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import FirebaseAuth
import Combine

@MainActor
class AuthManager: ObservableObject {
  @Published var currentUser: UserEntity?
  private let repository: AuthRepositoryProtocol

  init(repository: AuthRepositoryProtocol) {
    self.repository = repository
    self.currentUser = repository.checkActiveSession()
  }

  func setSession(_ user: UserEntity) {
    self.currentUser = user
  }

  func logOut() {
    try? Auth.auth().signOut()
    self.currentUser = nil
  }
}
