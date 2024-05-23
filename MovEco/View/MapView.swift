import SwiftUI
import MapKit
import CoreLocation
import Observation

struct MapView: View {
    
    @State private var locationManager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    @State private var showDetails = false
    @State private var showOverlay = true
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $mapSelection) {
                Marker("My location",systemImage: "person.fill", coordinate:  locationManager.location?.coordinate ?? CLLocationCoordinate2D())
                    .tint(.green)
                //                      Annotation("My safe area", coordinate: .userLocation) {
                //                        ZStack {
                //                          Circle()
                //                            .frame(width: 200, height: 200)
                //                            .foregroundStyle(.green.opacity(0.50))
                //                        }
                //                      }
                // Pour chaque élément du tableau MKMapItem génère un marker avec ses informations
                ForEach(results, id: \.self) { item in
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(Color(.systemGreen), lineWidth: 6)
                }
            }
            .onAppear{
                CLLocationManager().requestWhenInUseAuthorization()
            }
            .overlay(alignment: .bottom) {
                VStack(alignment: .trailing, spacing: 15){
                    NavigationLink(destination: FormLoginView()) {
                        ZStack{
                            Color.white
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .foregroundStyle(Color.white)
                                .background(Color.green)
                        }
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    }
                    ZStack(alignment: .trailing){
                        TextField("Rechercher une adresse", text: $searchText)
                            .font(.subheadline)
                            .padding(12)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 10)
                        Button(action: {
                            Task { await searchAddress() }
                            // Permet de cacher le clavier une fois la requete effectuer
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .frame(width: 60, height: 35)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.white)
                                .background(Color.green)
                                .clipShape(.rect(cornerRadius: 5))
                                .padding(5)
                        })
                    }
                }
                .padding()
            }
            // Submit la donnée avec entrée et envoie la fonction searchAdress
            .onSubmit(of: .text) {
                Task { await searchAddress() }
            }
            .onChange(of: getDirections, { oldValue, newValue in
                if newValue {
                    fetchRoute()
                }})
            .onChange(of: mapSelection, { oldValue, newValue in
                showDetails = newValue != nil
            })
            .sheet(isPresented: $showDetails, content: {
                AdressDetailsView(mapSelection: $mapSelection, show: $showDetails, getDirections: $getDirections)
                    .presentationDetents([.height(360)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
            })
            .mapControls{
                MapCompass()
                MapPitchToggle()
                MapUserLocationButton()
            }
        }
    }
}

extension MapView {
    // Permet la recherche d'emplacements locaux
    func searchAddress() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion.userRegion(locationManager: locationManager)
        let results = try? await MKLocalSearch(request: request).start()
        
        if let mapItems = results?.mapItems {
            // Effacer les résultats précédents
            self.results.removeAll()
            // Ajouter les nouveaux résultats
            self.results.append(contentsOf: mapItems)
            // Effacer le trajet affiché
            self.routeDisplaying = false
            self.route = nil
            
            // Calculer les coordonnées moyennes entre la position actuelle et la destination trouvée
            if let userCoordinate = locationManager.location?.coordinate {
                var minLat = userCoordinate.latitude
                var maxLat = userCoordinate.latitude
                var minLong = userCoordinate.longitude
                var maxLong = userCoordinate.longitude
                
                mapItems.forEach { mapItem in
                    let coordinate = mapItem.placemark.coordinate
                    minLat = min(minLat, coordinate.latitude)
                    maxLat = max(maxLat, coordinate.latitude)
                    minLong = min(minLong, coordinate.longitude)
                    maxLong = max(maxLong, coordinate.longitude)
                }
                
                // Calculer le centre de la carte
                let centerLat = (minLat + maxLat) / 2
                let centerLong = (minLong + maxLong) / 2
                
                // Calculer la région qui englobe à la fois la position actuelle et la destination trouvée
                let center = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLong)
                let span = MKCoordinateSpan(latitudeDelta: abs(maxLat - minLat) * 1.5, longitudeDelta: abs(maxLong - minLong) * 1.5)
                let region = MKCoordinateRegion(center: center, span: span)
                
                // Mettre à jour la position de la caméra avec la nouvelle région
                cameraPosition = .region(region)
                
            }
        }
    }
    
    // Récupère les données depuis l'API MapKit
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate:  locationManager.location?.coordinate ?? CLLocationCoordinate2D()))
            request.destination = mapSelection
            
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                routeDestination = mapSelection
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                }
            }
        }
    }
}
// Détermine les coordonnées de l'utilisateur
//extension CLLocationCoordinate2D {
//    static var userLocation: CLLocationCoordinate2D {
//        return .init(latitude: 43.56642, longitude: 1.39792)
//    }
//}
// Détermine les coordonées de la région
//extension MKCoordinateRegion {
//    static var userRegion: MKCoordinateRegion {
//        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
//    }
//}

extension MKCoordinateRegion {
    static func userRegion(locationManager: CLLocationManager) -> MKCoordinateRegion {
        let userCoordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D()
        return MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

#Preview {
    MapView()
}
