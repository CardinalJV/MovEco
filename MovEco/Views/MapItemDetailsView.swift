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
  
  @Binding var selectedMapItem: MKMapItem?
  @State private var lookAroundScene: MKLookAroundScene?
  
  var body: some View {
    VStack(spacing: -20){
      /* Header */
      HStack{
        VStack(alignment: .leading) {
          Text(selectedMapItem?.placemark.name ?? "")
            .font(.title2)
            .fontWeight(.semibold)
          
          Text(selectedMapItem?.placemark.title ?? "")
            .font(.footnote)
            .foregroundStyle(Color.gray)
            .lineLimit(2)
            .padding(.trailing)
        }
        Spacer()
        Button(action: {
          dismiss()
          self.selectedMapItem = nil
        }, label: {
          Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(.gray,Color(.systemGray6))
        })
      }
      .padding()
      /* - */
      /* Composant lookAroundScene */
      if self.lookAroundScene != nil {
        LookAroundPreview(initialScene: self.lookAroundScene)
          .frame(height: 200)
          .cornerRadius(12)
          .padding()
      } else {
        ContentUnavailableView("No preview available", systemImage: "eye.slash")
      }
      /* - */
      Spacer()
    }
    .task {
      self.lookAroundScene = await mapController.fetchLookAroundPreview(for: self.selectedMapItem)
    }
  }
}

  //#Preview {
  //    MapItemDetailsView()
  //}
