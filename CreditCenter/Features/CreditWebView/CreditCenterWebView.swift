//
//  CreditCenterWebView.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 15.05.23.
//

import SwiftUI
import AppsFlyerLib
import PopupView

struct CreditCenterWebView: View {
  
  @StateObject var webViewModel = WebViewViewModel()
  @State private var bottomSheetShown = false
 
 
  
  var body: some View {
        
      ZStack {
          VStack {
              Text(webViewModel.title)
                  .foregroundColor(.black)
          }
              WebViewContainer(webViewModel: webViewModel)
                  .ignoresSafeArea()
                  .popup(isPresented: $webViewModel.showPopup) {
                      PopupForSubscribeView(url: URL(string: "https://t.me/rian_ru")!)
                              } customize: {
                                  $0.type(.floater(verticalPadding: CGFloat(-40.0), useSafeAreaInset: true))
                                      .animation(.spring())
                              }
              if webViewModel.isLoading {
                  ProgressView()
                      .frame(height: 30)
              }
              if !webViewModel.hideBar {
                      WebControlView(webViewModel: webViewModel).padding(.top, 700)
              } else {
                 showControlBar()
              }
             
      }.onAppear {
          AppsFlyerLib.shared().logEvent(name: "ViewTime", values: [
            AFEventParamLong: "10",
            AFEventParamCustomerUserId: "12345"
          ])
      }
  }
    @ViewBuilder private func showControlBar() -> some View {
        ZStack {
            Button {
                webViewModel.hideBar.toggle()
            } label: {
                Image(systemName: "chevron.up.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
            }
        }.background(Color.gray.opacity(0.5))
         .cornerRadius(20)
         .padding(.bottom, 620)
         .padding(.leading, 310)
    }
}

struct CreditCenterWebView_Previews: PreviewProvider {
  static var previews: some View {
    CreditCenterWebView()
  }
}
