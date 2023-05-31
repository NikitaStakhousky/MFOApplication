//
//  TapButtonView.swift
//  CreditCenter
//
//  Created by Nikita Stshovsky on 30.05.2023.
//

import SwiftUI

struct TapButtonView: View {
    var image: String
    var action: () -> Void
    
    var body: some View {
      Button {
       action()
      } label: {
        Image(systemName: image)
          .resizable()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
    }
}
