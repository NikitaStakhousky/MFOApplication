//
//  AuthViewModel.swift
//  CreditCenter
//
//  Created by Stakhousky Nikita on 18.05.23.
//

import Foundation

final class AuthViewModel: ObservableObject {
  @Published var name: String = ""
  @Published var phoneNumber: String = ""
  @Published var email: String = ""
  @Published var loanAmount: Double = 0.0
  
  private let networkService = NetworkService()
  
  func sendData() {
    networkService.postUserData(name: name, phone: phoneNumber, email: email, loanAmount: loanAmount)
  }
}
