  //
  //  AdressDetailsView.swift
  //  TestMap
  //
  //  Created by Jessy Viranaiken on 03/05/2024.
  //

import SwiftUI
import MapKit

struct MapItemDetailsView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  let mapController: MapController
  
  @Binding var showRoute: Bool
  @Binding var mapItem: MKMapItem?
  @State private var lookAroundScene: MKLookAroundScene?
  
  var body: some View {
    if let mapItem = self.mapItem {
      VStack(spacing: 8){
        /* Header */
        HStack{
          VStack(alignment: .leading) {
            Text(mapItem.placemark.name ?? "")
              .font(.title2)
              .fontWeight(.semibold)
            
            Text(mapItem.placemark.title ?? "")
              .font(.footnote)
              .foregroundStyle(Color.gray)
              .lineLimit(2)
              .padding(.trailing)
          }
          Spacer()
          Button(action: {
            dismiss()
          }, label: {
            Image(systemName: "xmark.circle.fill")
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundStyle(.gray,Color(.systemGray6))
          })
        }
        /* - */
        /* Composant lookAroundScene */
        if self.lookAroundScene != nil {
          LookAroundPreview(initialScene: self.lookAroundScene)
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 8))
        } else {
          ContentUnavailableView("No preview available", systemImage: "eye.slash")
        }
        Button {
          self.showRoute = true
          dismiss()
        } label: {
          HStack{
            Text("GO")
            Image(systemName: "hand.thumbsup.fill")
          }
        }
        .frame(width: 375, height: 50)
        .background(.green)
        .clipShape(.rect(cornerRadius: 8))
        .font(.title)
        .foregroundStyle(.white)
        .bold()
        /* - */
        Spacer()
      }
      .padding()
      .task {
        self.lookAroundScene = await mapController.fetchLookAroundPreview(for: self.mapItem)
      }
    } else {
      Text("Impossible de récupérer les informations.")
    }
  }
}

  //#Preview {
  //    MapItemDetailsView()
  //}
