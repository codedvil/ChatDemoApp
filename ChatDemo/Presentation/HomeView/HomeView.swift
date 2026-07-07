//
//  HomeView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var authManager: AuthManager

  var body: some View {
    TabView {
      ChatListView()
        .tabItem {
          Label("Chats", systemImage: "message.fill")
        }

      if let user = authManager.currentUser {
        let repository = FirebaseProfileRepository()
        let getUseCase = GetProfileUseCase(repository: repository)
        let saveUseCase = SaveProfileUseCase(repository: repository)
        let uploadImageUseCase = UploadProfileImageUseCase(repository: repository)
        let profileViewModel = ProfileViewModel(
          userId: user.id,
          getProfileUseCase: getUseCase,
          saveProfileUseCase: saveUseCase,
          uploadImageUseCase: uploadImageUseCase
        )

        ProfileView(authManager: authManager, viewModel: profileViewModel)
          .tabItem {
            Label("Perfil", systemImage: "person.crop.circle.fill")
          }
      }
    }
  }
}
