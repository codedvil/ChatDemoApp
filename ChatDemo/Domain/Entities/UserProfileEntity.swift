//
//  UserProfileEntity.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import Foundation

struct UserProfileEntity: Codable {
  let id: String
  var name: String
  var bio: String
  let email: String
  var profileImageUrl: String?
}
