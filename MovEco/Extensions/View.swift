//
//  View.swift
//  MovEco
//
//  Created by Jessy Viranaiken on 23/09/2024.
//

import SwiftUI

extension View {
  func dismissKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
