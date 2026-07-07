//
//  RegisterViewModel.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Combine

@MainActor
class RegisterViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var isLoading = false
  @Published var errorMessage: String?

  private let signUpUseCase: SignUpUseCase
  var onRegistrationSuccess: (UserEntity) -> Void

  init(signUpUseCase: SignUpUseCase,
       onRegistrationSuccess: @escaping (UserEntity) -> Void) {
    self.signUpUseCase = signUpUseCase
    self.onRegistrationSuccess = onRegistrationSuccess
  }

  func register() {
    guard password == confirmPassword else {
      errorMessage = "Las contraseñas no coinciden"
      return
    }

    isLoading = true
    Task {
      do {
        let user = try await signUpUseCase.execute(email: email, password: password)
        onRegistrationSuccess(user)
      } catch {
        errorMessage = "¡Oops! Algo salió mal. Intenta nuevamente."
      }
      isLoading = false
    }
  }
}
