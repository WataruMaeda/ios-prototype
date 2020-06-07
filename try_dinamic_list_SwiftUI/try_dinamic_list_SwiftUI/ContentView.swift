//
//  ContentView.swift
//  try_dinamic_list_SwiftUI
//
//  Created by Wataru Maeda on 2020/06/07.
//  Copyright © 2020 Wataru Maeda. All rights reserved.
//
// List View
// https://www.youtube.com/watch?v=bz6GTYaIQXU
//
// Horizontal
// https://www.youtube.com/watch?v=7QgPpvqTfeo

import SwiftUI

struct User: Identifiable {
  let id: Int
  let username, message, imageName: String
}

struct ContentView: View {
  let users: [User] = [
    .init(id: 0, username: "Dog", message: "iPhone is now on sale", imageName: "dog"),
    .init(id: 1, username: "Cat", message: "iPhone is now on sale", imageName: "cat"),
    .init(id: 2, username: "Bird", message: "iPhone is now on sale iPhone is now on sale iPhone is now on sale iPhone is now on sale iPhone is now on sale iPhone is now on sale", imageName: "bird"),
  ]

  var body: some View {
    NavigationView {
      List {
        ForEach(users, id: \.id) { user in
          UserView(user: user)
        }
      }.navigationBarTitle(Text("Dynamic List"))
    }
  }
}

struct UserView: View {
  let user: User
  var body: some View {
    HStack {
      Image(user.imageName)
      .resizable()
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .clipped()
          VStack (alignment: .leading) {
        Text(user.username).font(.headline)
        Text(user.message).font(.caption)
        }.padding(.leading, 8)
    }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
