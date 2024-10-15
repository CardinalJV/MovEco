  //
  //  ContentView.swift
  //  MovEco
  //
  //  Created by Jessy Viranaiken on 26/08/2024.
  //

import SwiftUI
import MapKit
import CoreLocation
//import Foundation

struct MapView: View {
  
  let mapController = MapController()
  
  @State var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
  @State var selectedMapItem: MKMapItem?
  @State var showDetails = false
  @State var searchText = ""
  @State var showRoute = false
  @State var route: MKPolyline? = nil
  
  var body: some View {
    Map(position: self.$cameraPosition, selection: self.$selectedMapItem){
      if let userCoordinate = mapController.locationManager.location?.coordinate {
        Marker("My location", systemImage: "person.fill", coordinate: userCoordinate)
      }
      ForEach(mapController.mapItems, id:\.self){ mapItem in
        if self.showRoute {
          if let mapItem = self.selectedMapItem {
            Marker(mapItem.name ?? "Inconnu", coordinate: mapItem.placemark.coordinate)
          }
        } else {
          Marker(mapItem.name ?? "Inconnu", coordinate: mapItem.placemark.coordinate)
            .tint(.green)
        }
      }
      if self.showRoute {
        if let route = self.route {
          withAnimation(.snappy){
            MapPolyline(route)
              .stroke(.green, lineWidth: 5)
          }
        }
      }
    }
    .onAppear{
      CLLocationManager().requestWhenInUseAuthorization()
    }
    .onChange(of: self.mapController.mapItems){
      self.showRoute = false
    }
    .onChange(of: self.selectedMapItem) {
      if self.selectedMapItem != nil {
        self.showDetails.toggle()
      }
    }
    .onChange(of: self.showRoute) {
      Task {
        self.route = await self.mapController.generateRouteFromSource(to: self.selectedMapItem!)!
        if let route = self.route {
          self.cameraPosition = .rect(route.boundingMapRect.insetBy(dx: -route.boundingMapRect.size.width * 0.25, dy: -route.boundingMapRect.size.height * 0.25))
        }
      }
    }
    .overlay(alignment: .bottom){
      SearchBar(mapController: self.mapController, searchText: self.$searchText, cameraPosition: self.$cameraPosition)
    }
    .sheet(isPresented: self.$showDetails){
      MapItemDetailsView(mapController: self.mapController, showRoute: self.$showRoute, mapItem: self.$selectedMapItem)
        .presentationDetents([.fraction(0.5)])
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
