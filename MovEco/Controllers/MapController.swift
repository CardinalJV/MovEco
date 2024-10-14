  //
  //  MapViewModel.swift
  //  MovEco
  //
  //  Created by Jessy Viranaiken on 23/08/2024.
  //

import MapKit

@Observable
class MapController {
  
    // Ce tableau stockera les résultats de recherches
  var mapItems = [MKMapItem]()
    // Récupère la localisation de l'utilisateur si ce dernier accepte
  var locationManager = CLLocationManager()
  
  func searchPlaces(query: String) async {
      // Vérifie que l'utilisateur soit géolocalisable sinon return nil
    guard let userLocation = locationManager.location else { return }
      // Création de la requete afin de récupérer les potentiels occurences
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = query
    request.region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
      // Envoie de la requete
    let search = try? await MKLocalSearch(request: request).start()
      // Récupération des résultats dans le tableau mapItems
    if let results = search?.mapItems {
      self.mapItems.removeAll()
      self.mapItems.append(contentsOf: results)
    }
  }
  
  func fetchLookAroundPreview(for selectedMapItem: MKMapItem?) async -> MKLookAroundScene? {
      // Vérifie que le mapItem n'est pas nil
    guard let selectedMapItem = selectedMapItem else {
      return nil
    }
      // Lance une requete pour récupérer un MKLookAroundScene
    do {
      let request = MKLookAroundSceneRequest(mapItem: selectedMapItem)
      return try await request.scene
    } catch {
      print("Erreur lors du chargement de la scène : \(error.localizedDescription)")
      return nil
    }
  }
  
  func calculateRegion() -> MKCoordinateRegion? {
      // Vérifie que le tableau mapItems n'est pas vide sinon retourne nil
    guard !self.mapItems.isEmpty else {
      return nil
    }
      // Extraire les coordonnées des résultats de recherche
    let coordinates = self.mapItems.map { $0.placemark.coordinate }
      // Trouver les valeurs min/max pour latitude et longitude
    let initialCoordinate = coordinates[0]
    let boundingBox = coordinates.reduce((minLat: initialCoordinate.latitude, maxLat: initialCoordinate.latitude, minLong: initialCoordinate.longitude, maxLong: initialCoordinate.longitude)) { (currentBounds, coordinate) in
      return (
        minLat: min(currentBounds.minLat, coordinate.latitude),
        maxLat: max(currentBounds.maxLat, coordinate.latitude),
        minLong: min(currentBounds.minLong, coordinate.longitude),
        maxLong: max(currentBounds.maxLong, coordinate.longitude)
      )
    }
      // Calculer le centre de la région
    let centerLat = (boundingBox.minLat + boundingBox.maxLat) / 2
    let centerLong = (boundingBox.minLong + boundingBox.maxLong) / 2
    let centerCoordinate = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong)
      // Calculer le span (latitude/longitude)
    let latDelta = max(boundingBox.maxLat - boundingBox.minLat, 0.01)
    let longDelta = max(boundingBox.maxLong - boundingBox.minLong, 0.01)
    let span = MKCoordinateSpan(latitudeDelta: latDelta * 1.5, longitudeDelta: longDelta * 1.5)
      // Retourne le résultat afin de définir la cameraPosition sur la région
    return MKCoordinateRegion(center: centerCoordinate, span: span)
  }
  
  func generateRouteFromSource(to destination: MKMapItem) async -> MKPolyline? {
    guard let userLocation = locationManager.location else { return nil }
    
    let source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
    let directionRequest = MKDirections.Request()
    directionRequest.source = source
    directionRequest.destination = destination
    directionRequest.transportType = .automobile
    let directions = MKDirections(request: directionRequest)
    do {
      let response = try await directions.calculate()
      if let route = response.routes.first {
        return route.polyline
      } else {
        print("Aucune route trouvée.")
        return nil
      }
    } catch {
      print("Erreur lors de la génération de la route : \(error.localizedDescription)")
      return nil
    }
  }
  
}
