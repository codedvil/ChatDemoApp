//
//  ProfileViewModel.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import Combine
import SwiftUI
import PhotosUI
import UIKit

@MainActor
class ProfileViewModel: ObservableObject {
  @Published var name: String = ""
  @Published var bio: String = ""
  @Published var email: String = ""
  @Published var isLoading: Bool = false
  @Published var errorMessage: String? = nil
  @Published var isEditing: Bool = false
  // Image loading
  @Published var currentProfileImageURL: String? = nil
  @Published var uiImage: UIImage? = nil
  @Published var imageUploading: Bool = false
  // PhotosUI
  @Published var selectedItem: PhotosPickerItem? = nil {
    didSet {
      Task {
        try? await loadPickedImage()
      }
    }
  }

  private let userId: String
  private let getProfileUseCase: GetProfileUseCase
  private let saveProfileUseCase: SaveProfileUseCase
  private let uploadImageUseCase: UploadProfileImageUseCase

  init(userId: String,
       getProfileUseCase: GetProfileUseCase,
       saveProfileUseCase: SaveProfileUseCase,
       uploadImageUseCase: UploadProfileImageUseCase) {
    self.userId = userId
    self.getProfileUseCase = getProfileUseCase
    self.saveProfileUseCase = saveProfileUseCase
    self.uploadImageUseCase = uploadImageUseCase
  }

  func loadProfile(userEmail: String) {
    isLoading = true
    errorMessage = nil

    Task {
      do {
        let profile = try await getProfileUseCase.execute(userId: userId)
        self.name = profile.name
        self.bio = profile.bio
        self.email = profile.email
        self.currentProfileImageURL = profile.profileImageUrl
      } catch {
        self.email = userEmail
        self.name = userEmail.components(separatedBy: "@").first ?? "Usuario"
        self.bio = "Mi Bio editable..."
      }
      isLoading = false
    }
  }

  private func loadPickedImage() async throws {
    guard let data = try? await selectedItem?.loadTransferable(type: Data.self) else { return }
    guard let image = UIImage(data: data) else { return }
    self.uiImage = image
  }

  private func uploadAndSaveImage(image: UIImage) {
    imageUploading = true
    errorMessage = nil
    
    Task {
      do {
        let newImageUrl = try await uploadImageUseCase.execute(userId: userId, image: image)
        self.currentProfileImageURL = newImageUrl
        let updatedProfile = UserProfileEntity(id: userId,
                                               name: name,
                                               bio: bio,
                                               email: email,
                                               profileImageUrl: newImageUrl)
        try await saveProfileUseCase.execute(profile: updatedProfile)
        self.uiImage = nil
        self.selectedItem = nil
      } catch {
        // TODO: Image save will always fail since Firebase Storage must be paid
        self.errorMessage = "No se pudo subir la foto. Intenta más tarde."
      }
      imageUploading = false
    }
  }

  func saveChanges() {
    isLoading = true
    errorMessage = nil

    if let newImage = uiImage {
      uploadAndSaveImage(image: newImage)
    }

    let updatedProfile = UserProfileEntity(id: userId,
                                           name: name,
                                           bio: bio,
                                           email: email,
                                           profileImageUrl: currentProfileImageURL)

    Task {
      do {
        try await saveProfileUseCase.execute(profile: updatedProfile)
        self.isEditing = false
      } catch {
        self.errorMessage = "No se pudo guardar el perfil. Inténtalo más tarde"
      }
      isLoading = false
    }
  }
}
