//
//  WebViewControl.swift
//  CreditCenter
//
//  Created by Nikita Stshovsky on 30.05.2023.
//

import SwiftUI

struct WebControlView: View {
    
    @ObservedObject var webViewModel: WebViewViewModel
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
          HStack(spacing: 26) {
              TapButtonView(image: "house") {
                  webViewModel.goHome.toggle()
                  }
              TapButtonView(image: "chevron.backward.circle") {
                  webViewModel.shouldGoBack.toggle()
                  }
              TapButtonView(image: "gobackward") {
                  webViewModel.shouldReload.toggle()
                  }
              TapButtonView(image: "bubble.right") {
                  webViewModel.showPopup.toggle()
                  }
              TapButtonView(image: "chevron.down.circle") {
                  webViewModel.hideBar.toggle()
                  }
          }
          .padding(.horizontal, 20)
          .padding(.vertical, 16)
          .background(Color.gray.opacity(0.6))
          .cornerRadius(20)
          .padding(.horizontal)

        }
    }
}
