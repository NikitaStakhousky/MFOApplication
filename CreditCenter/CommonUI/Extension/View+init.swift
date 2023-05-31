//
//  View + init.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 12.05.23.
//

import SwiftUI
import Foundation

extension View {
  func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
    ZStack(alignment: alignment) {
      placeholder().opacity(shouldShow ? 1 : 0)
      self
    }
  }
}
