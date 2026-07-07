//
//  ProfileView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
  @ObservedObject var authManager: AuthManager
  @StateObject var viewModel: ProfileViewModel

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        if viewModel.isLoading {
          Spacer()
          ProgressView("Cargando Perfil...")
          Spacer()
        } else {
          ZStack {
            if let uiImage = viewModel.uiImage {
              Image(uiImage: uiImage)
                .resizable()
            } else if let imageUrlString = viewModel.currentProfileImageURL,
                      let url = URL(string: imageUrlString) {
              AsyncImage(url: url) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
            } else {
              Image(systemName: "person.crop.circle.fill")
                .resizable()
                .foregroundColor(.gray)
            }
          }
          .scaledToFill()
          .frame(width: 120, height: 120)
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.white, lineWidth: 4))
          .shadow(radius: 7)
          .padding(.top)
          .overlay {
            if viewModel.imageUploading {
              ProgressView()
                .background(Color.black.opacity(0.4))
                .clipShape(Circle())
            }
          }
          .overlay(alignment: .bottomTrailing) {
            if viewModel.isEditing {
              PhotosPicker(selection: $viewModel.selectedItem,
                           matching: .images,
                           photoLibrary: .shared()) {
                Image(systemName: "pencil.circle.fill")
                  .symbolRenderingMode(.multicolor)
                  .font(.system(size: 30))
                  .background(Color.white.clipShape(Circle()))
              }
            }
          }
          Form {
            Section(header: Text("Información Personal")) {
              if viewModel.isEditing {
                TextField("Nombre", text: $viewModel.name)
                TextField("Mi Info", text: $viewModel.bio)
              } else {
                HStack {
                  Text("Nombre")
                  Spacer()
                  Text(viewModel.name)
                    .foregroundColor(.secondary)
                }
                HStack {
                  Text("Biografía")
                  Spacer()
                  Text(viewModel.bio)
                    .foregroundColor(.secondary)
                }
              }
              HStack {
                Text("Email")
                Spacer()
                Text(viewModel.email)
                  .foregroundColor(.gray)
              }
            }
            Section {
              Button {
                if viewModel.isEditing {
                  viewModel.saveChanges()
                } else {
                  viewModel.isEditing = true
                }
              } label: {
                Text(viewModel.isEditing ? "Guardar Cambios" : "Editar Perfil")
                  .frame(maxWidth: .infinity, alignment: .center)
              }
              .foregroundColor(viewModel.isEditing ? .green : .blue)

              if viewModel.isEditing {
                Button("Cancelar") {
                  viewModel.isEditing = false
                  if let user = authManager.currentUser {
                    viewModel.loadProfile(userEmail: user.email)
                  }
                }
                .foregroundColor(.red)
              }
            }
          }
        }

        if let error = viewModel.errorMessage {
          Text(error)
            .foregroundColor(.red)
            .font(.caption)
            .padding()
        }

        Button {
          authManager.logOut()
        } label: {
          Text("Cerrar sesión")
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(.red.opacity(0.1))
            .foregroundColor(.red)
            .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom, 30)
      }
      .navigationTitle("Mi Perfil")
      .onAppear {
        if let user = authManager.currentUser {
          viewModel.loadProfile(userEmail: user.email)
        }
      }
    }
  }
}
