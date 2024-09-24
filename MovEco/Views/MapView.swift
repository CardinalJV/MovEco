  //
  //  ContentView.swift
  //  MovEco
  //
  //  Created by Jessy Viranaiken on 26/08/2024.
  //

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
  
  let mapController = MapController()
  
  @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
  @State var selectedMapItem: MKMapItem?
  @State var showDetails = false
  @State var searchText = ""
  
  var body: some View {
    Map(position: self.$cameraPosition, selection: self.$selectedMapItem){
      if let userCoordinate = mapController.locationManager.location?.coordinate {
        Marker("My location", systemImage: "person.fill", coordinate: userCoordinate)
      }
      ForEach(mapController.mapItems, id:\.self){ mapItem in
        Marker(mapItem.name ?? "Inconnu", coordinate: mapItem.placemark.coordinate)
          .tint(.green)
      }
    }
    .tint(.green)
    .onAppear{
      CLLocationManager().requestWhenInUseAuthorization()
    }
    .onChange(of: self.selectedMapItem) {
      if self.selectedMapItem != nil {
        self.showDetails = true
      }
    }
    .sheet(isPresented: self.$showDetails){
      MapItemDetailsView(mapController: self.mapController, mapItem: self.$selectedMapItem)
        .presentationDetents([.fraction(0.5)])
    }
    .overlay(alignment: .bottom){
      SearchBar(mapController: self.mapController, searchText: self.$searchText, cameraPosition: self.$cameraPosition)
    }
    .mapControls{
      MapCompass()
      MapPitchToggle()
      MapUserLocationButton()
    }
  }
}

#Preview {
  MapView()
}
