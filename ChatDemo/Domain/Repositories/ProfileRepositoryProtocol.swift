//
//  ProfileRepositoryProtocol.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation
import UIKit

protocol ProfileRepositoryProtocol {
  func fetchProfile(userId: String) async throws -> UserProfileEntity
  func saveProfile(profile: UserProfileEntity) async throws
  func uploadProfileImage(userId: String, image: UIImage) async throws -> String
}
