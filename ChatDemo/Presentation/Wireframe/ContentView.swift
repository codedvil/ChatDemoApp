//
//  ContentView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var authManager: AuthManager

  var body: some View {
    Group {
      if authManager.currentUser != nil {
        HomeView()
      } else {
        NavigationStack {
          LoginView(viewModel: makeLoginViewModel())
            .navigationDestination(for: String.self) { view in
              if view == "register" {
                RegisterView(viewModel: makeRegisterViewModel())
              }
            }
        }
      }
    }
  }

  private func makeLoginViewModel() -> LoginViewModel {
    let repository = FirebaseAuthRepository()
    let useCase = LogincUseCase(repository: repository)
    return LoginViewModel(loginUseCase: useCase) { user in
      authManager.setSession(user)
    }
  }

  private func makeRegisterViewModel() -> RegisterViewModel {
    let repository = FirebaseAuthRepository()
    let useCase = SignUpUseCase(repository: repository)
    return RegisterViewModel(signUpUseCase: useCase) { user in
      authManager.setSession(user)
    }
  }
}
