  //
  //  LaunchingTabView.swift
  //  MovEco
  //
  //  Created by Jessy Viranaiken on 07/05/2024.
  //

import SwiftUI

struct SplashScreenView: View {
  
  @State private var isActive = false
  
  var body: some View {
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
  }
}

#Preview {
  SplashScreenView()
}
