//
//  LoginViewModel.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var errorMessage: String? = nil
  @Published var userAuthenticated: UserEntity? = nil

  private let loginUseCase: LogincUseCase
  var onLoginSuccess: (UserEntity) -> Void

  init(loginUseCase: LogincUseCase,
       onLoginSuccess: @escaping (UserEntity) -> Void) {
    self.loginUseCase = loginUseCase
    self.onLoginSuccess = onLoginSuccess
  }

  func login() {
    guard !email.isEmpty, !password.isEmpty else {
      errorMessage = "Por favor llena todos los campos."
      return
    }

    isLoading = true
    errorMessage = nil

    Task {
      do {
        let user = try await loginUseCase.execute(email: email, password: password)
        self.userAuthenticated = user
        self.isLoading = false
        self.onLoginSuccess(user)
      } catch {
        self.errorMessage = "¡Oops! Algo salió mal. Intenta nuevamente o regístrate."
        self.isLoading = false
      }
    }
  }
}
