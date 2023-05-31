//
//  TextFields.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 12.05.23.
//

import SwiftUI

struct TextFieldsModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
    .frame(height: 54)
    .foregroundColor(.white)
    .background(Color.textFields)
    .cornerRadius(12)
    .padding()
    .multilineTextAlignment(.center)
    .frame(maxWidth: .infinity)
  }
}
