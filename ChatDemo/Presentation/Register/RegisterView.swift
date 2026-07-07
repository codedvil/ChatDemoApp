//
//  RegisterView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI

struct RegisterView: View {
  @StateObject var viewModel: RegisterViewModel
  @Environment(\.dismiss) var dismiss

  var body: some View {
    VStack(spacing: 20) {
      Text("Crear cuenta")
        .font(.largeTitle).bold()

      TextField("Email", text: $viewModel.email)
        .textFieldStyle(.roundedBorder).autocapitalization(.none)

      SecureField("Contraseña", text: $viewModel.password)
        .textFieldStyle(.roundedBorder)

      SecureField("Confirmar contraseña", text: $viewModel.confirmPassword)
        .textFieldStyle(.roundedBorder)

      if let error = viewModel.errorMessage {
        Text(error).foregroundColor(.red)
          .font(.caption)
      }

      Button {
        viewModel.register()
      } label: {
        if viewModel.isLoading {
          ProgressView()
        } else {
          Text("Registrarme")
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
        }
      }
      .background(.green)
      .foregroundColor(.white)
      .cornerRadius(10)

      Button("¿Ya tienes cuenta? Inicia sesión") {
        dismiss()
      }
    }
    .padding()
  }
}
