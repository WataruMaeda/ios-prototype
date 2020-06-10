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

struct Animal: Identifiable {
  let id: Int
  let name, message, imageName: String
}

struct ContentView: View {
  let animals: [Animal] = [
    .init(id: 0, name: "Dog", message: "Baw Baw", imageName: "dog"),
    .init(id: 1, name: "Cat", message: "Mew", imageName: "cat"),
    .init(id: 2, name: "Bird", message: "Pipipipi", imageName: "bird"),
  ]

  var body: some View {
    NavigationView {
      List {
        VStack {
          VStack(alignment: .leading) {
          Text("Trending").padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
          ScrollView(.horizontal) {
              HStack {
                ForEach(animals, id: \.id) { animal in
                  FeatureView(animal: animal)
                }
              }
            }
          }
        }
        ForEach(animals, id: \.id) {
          UserView(animal: $0)
        }
      }.navigationBarTitle(Text("Dynamic List"))
    }
  }
}

struct FeatureView: View {
  var animal: Animal
  var body: some View {
    NavigationLink(destination: FeatureDetailView(animal: animal)) {
      VStack(alignment: .leading) {
        Image(animal.imageName).renderingMode(.original).frame(width: 100, height: 100).padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0)).clipped().cornerRadius(10)
        Text(animal.name).foregroundColor(.primary).font(.system(size: 14)).lineLimit(nil)
      }
    }
  }
}

struct FeatureDetailView: View {
  var animal: Animal
  var body: some View {
    VStack {
      Image(animal.imageName)
      Text(animal.name)
      Text(animal.message)
    }
  }
}

struct UserView: View {
  let animal: Animal
  var body: some View {
    HStack {
      Image(animal.imageName)
      .resizable()
        .frame(width: 70, height: 70)
        .clipShape(Circle())
        .clipped()
          VStack (alignment: .leading) {
        Text(animal.name).font(.headline)
        Text(animal.message).font(.caption)
        }.padding(.leading, 8)
    }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
