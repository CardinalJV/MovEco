//
//  Place.swift
//  MovEco
//
//  Created by Jessy Viranaiken on 23/08/2024.
//

import Foundation
import MapKit

struct Place {
  let id = UUID()
  let name: String
  let location: CLLocation
  let adress: String?
}
