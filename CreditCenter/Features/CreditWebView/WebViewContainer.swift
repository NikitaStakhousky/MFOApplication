//
//  WebViewContainer.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 15.05.23.
//

import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
  
  @ObservedObject var webViewModel: WebViewViewModel
  
  func makeCoordinator() -> WebViewContainer.Coordinator {
    Coordinator(webViewModel: webViewModel, parent: self)
  }
  
  func makeUIView(context: Context) -> WKWebView {
      guard let url = URL(string: webViewModel.currentWebView()) else {
      return WKWebView()
    }
    let request = URLRequest(url: url)
            let webView = WKWebView()
            webView.navigationDelegate = context.coordinator
            webView.load(request)
      
      
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if webViewModel.shouldGoBack {
      uiView.goBack()
        
        webViewModel.shouldGoBack = false
    }
      if webViewModel.shouldReload {
          uiView.reload()
          
          webViewModel.shouldReload = false
      }
      if webViewModel.goHome {
          guard let  item = uiView.backForwardList.backList.first else {return}
          uiView.go(to: item)
          webViewModel.goHome = false
      }
  }
}
