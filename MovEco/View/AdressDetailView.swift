//
//  AdressDetailsView.swift
//  TestMap
//
//  Created by apprenant58 on 03/05/2024.
//

import SwiftUI
import MapKit

struct AdressDetailsView: View {
    
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    @Binding var getDirections: Bool
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.footnote)
                        .foregroundStyle(Color.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                //                .padding()
                .padding(.top)
                Spacer()
                Button(action: {
                    show.toggle()
                    mapSelection = nil
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray,Color(.systemGray6))
                })
            }
            .padding(.init(top: 10, leading: 15, bottom: 10, trailing: 15))
            
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
            
            HStack(spacing: 20) {
                Button {
                    if let mapSelection {
                        mapSelection.openInMaps()
                    }
                } label: {
                    Text("Ouvrir dans la carte")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 48)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button {
                    getDirections = true
                    show = false
                } label: {
                    Text("GO !")
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(width: 170, height: 48)
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(10)
        }
        .onAppear{
            fetchLookAroundPreview()
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            fetchLookAroundPreview()
        }
    }
}
// Récupère les image de l'adresse sélectionée
extension AdressDetailsView {
    func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
}

#Preview {
    AdressDetailsView(mapSelection: .constant(nil), show: .constant(false), getDirections: .constant(false))
}
