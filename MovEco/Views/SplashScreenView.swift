//
//  LaunchingTabView.swift
//  MovEco
//
//  Created by Jessy Viranaiken on 07/05/2024.
//

import SwiftUI

struct LaunchingView: View {
  
  @State private var isActive = false
  
    var body: some View {
      if isActive {
        TabView(selection: .constant(1)) {
          MovIzzView()
            .tabItem {
              Label("My MovIzz", systemImage: "person.fill.checkmark")
            }
          MapView()
            .tabItem {
              Label("MovMap", systemImage: "map.fill")
            }
            .tag(1)
          NewUserProfilView()
            .tabItem {
              Label("MovAccount", systemImage: "person.circle.fill")
            }
        }
        .tint(Color.green)
      } else {
        VStack{
          Image(systemName: "LaunchingImage")
            .resizable()
            .frame(width: 100, height: 100)
        }
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
              self.isActive = true
            }
          }
        }
      }
    }
}

#Preview {
    LaunchingView()
}
