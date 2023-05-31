//
//  WebViewViewModel.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 15.05.23.
//

import Foundation
import WebKit

@MainActor
final class WebViewViewModel: ObservableObject {
  @Published var isLoading: Bool = false
  @Published var canGoBack: Bool = false
  @Published var reload: Bool = false
  @Published var shouldReload: Bool = false
  @Published var hideBar: Bool = false
  @Published var goHome: Bool = false
  @Published var shouldGoBack: Bool = false
  @Published var showPopup = false
  @Published var title: String = ""
  @Published var showBottomSheet: Bool = false
    
    
  
  func currentWebView() -> String {
      var url = ""
      let langCode = Bundle.main.preferredLocalizations[0]
      let usLocale = Locale(identifier: "en-US")
      var langName = ""
      if let languageName = usLocale.localizedString(forLanguageCode: langCode) {
          langName = "ru"
      }
    if langName == "ru" {
      url = "https://qdqgury.com/46302?r=32115&itb"
    } else if langName == "kk-KZ" {
      url = "https://qdqgury.com/43118?r=32115&itb"
    } else if langName ==  "vi"{
      url = "https://qdqgury.com/45694?r=32115&itb"
    } else if langName == "ro-RO" {
      url = "https://qdqgury.com/46032?r=32115&itb"
    } else if langName == "mx" {
      url = "https://qdqgury.com/45785?r=32115&itb"
    }
      print(langName)
    return url 
  }
    
}
