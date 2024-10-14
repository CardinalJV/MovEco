  //
  //  SearchBar.swift
  //  MovEco
  //
  //  Created by Jessy Viranaiken on 23/09/2024.
  //

import SwiftUI
import MapKit

struct SearchBar: View {
  
  let mapController: MapController
  
  @Binding var searchText: String
  @Binding var cameraPosition: MapCameraPosition
  
  var body: some View {
    ZStack{
      HStack{
        TextField("Rechercher une adresse", text: $searchText)
          .font(.subheadline)
        if !self.searchText.isEmpty {
          Button {
            self.searchText.removeAll()
          } label: {
              Image(systemName: "xmark.circle.fill")
          }
        }
        Button(action: {
          Task {
            await mapController.searchPlaces(query: searchText)
            if let region = mapController.calculateRegion() {
              withAnimation(.easeInOut(duration: 1.5)) { // Durée de l'animation à 1.5 secondes
                self.cameraPosition = .region(region)
              }
            }
          }
          dismissKeyboard()
        }, label: {
          Image(systemName: "magnifyingglass")
            .frame(width: 60, height: 35)
            .font(.title3)
            .bold()
            .foregroundStyle(Color.white)
            .background(Color.green)
            .clipShape(.rect(cornerRadius: 6))
        })
        
      }
      .frame(height: 45, alignment: .leading)
      .padding(.init(top: .zero, leading: 15, bottom: .zero, trailing: 5))
      .background(.white)
      .clipShape(.rect(cornerRadius: 8))
      .shadow(radius: 10)
    }
    .onSubmit {
      Task{
        await mapController.searchPlaces(query: searchText)
        if let region = mapController.calculateRegion() {
          withAnimation(.easeInOut(duration: 1.5)) {
            self.cameraPosition = .region(region)
          }
        }
      }
      dismissKeyboard()
    }
    .padding(.init(top: .zero, leading: 5, bottom: 30, trailing: 5))
  }
}
