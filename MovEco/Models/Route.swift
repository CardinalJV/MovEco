//
//  Route.swift
//  MovEco
//
//  Created by Jessy Viranaiken on 23/08/2024.
//

import Foundation
import MapKit

struct Route {
  let startPlace: Place
  let endPlace: Place
  let distance: CLLocationDistance
  let expectedTravelTime: TimeInterval
  let polyline: MKPolyline
}
