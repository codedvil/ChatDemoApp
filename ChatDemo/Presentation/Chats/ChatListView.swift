//
//  ChatListView.swift
//  ChatDemo
//
//  Created by Edgar Vilchis on 06/07/26.
//

import SwiftUI

struct ChatListView: View {
  var body: some View {
    NavigationStack {
      List {
        Text("Chat con Juan")
        Text("Chat con María")
      }
      .navigationTitle("Mensajes")
    }
  }
}
