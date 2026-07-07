//
//  FirebaseProfileRepository.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import UIKit

class FirebaseProfileRepository: ProfileRepositoryProtocol {
  private let dataBase = Firestore.firestore()
  private let storage = Storage.storage().reference()

  func fetchProfile(userId: String) async throws -> UserProfileEntity {
    let document = try await dataBase.collection("users").document(userId).getDocument()

    if document.exists {
      if let profile = try? document.data(as: UserProfileEntity.self) {
        return profile
      }
    }

    throw NSError(domain: "ProfileRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Perfil no encontrado"])
  }

  func saveProfile(profile: UserProfileEntity) async throws {
    try dataBase.collection("users").document(profile.id).setData(from: profile)
  }

  func uploadProfileImage(userId: String, image: UIImage) async throws -> String {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      throw NSError(domain: "ProfileRepository", code: 500, userInfo: [NSLocalizedDescriptionKey: "No se pudo comprimir la imagen"])
    }

    let fileReference = storage.child("users").child(userId).child("profile.jpg")
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpeg"
    _ = try await fileReference.putDataAsync(imageData, metadata: metaData)
    let downloadURL = try await fileReference.downloadURL()
    return downloadURL.absoluteString
  }
}
