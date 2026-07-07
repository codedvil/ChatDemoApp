//
//  LoginView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI

struct LoginView: View {
  @StateObject var viewModel: LoginViewModel

  var body: some View {
    VStack(spacing: 20) {
      Text("Iniciar sesión")
        .font(.largeTitle)
        .bold()

      TextField("Correo electrónico", text: $viewModel.email)
        .textFieldStyle(.roundedBorder)
        .autocapitalization(.none)
        .keyboardType(.emailAddress)

      SecureField("Contraseña", text: $viewModel.password)
        .textFieldStyle(.roundedBorder)

      if let error = viewModel.errorMessage {
        Text(error)
          .foregroundColor(.red)
          .font(.caption)
      }

      if viewModel.isLoading {
        ProgressView()
      } else {
        Button {
          viewModel.login()
        } label: {
          Text("Ingresar")
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }

      NavigationLink(value: "register") {
        Text("¿No tienes cuenta? Registrate aquí")
          .font(.footnote)
          .foregroundColor(.blue)
      }

      if let user = viewModel.userAuthenticated {
        Text("¡Bienvenido! ID: \(user.id)")
          .foregroundColor(.green)
      }
    }
    .padding()
  }
}
