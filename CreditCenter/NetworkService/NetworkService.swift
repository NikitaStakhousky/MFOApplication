//
//  NetworkService.swift
//  CreditCenter
//
//  Created by Maksim Chizhavko on 18.05.23.
//

import Foundation

final class NetworkService {
  
  func postUserData(name: String, phone: String, email: String, loanAmount: Double) {
    let parameters = "name=\(name)&phone=\(phone)&email=\(email)&loanAmount=\(loanAmount)&geo=by"
    let postData =  parameters.data(using: .utf8)
    guard let url = URL(string: "https://one-fin.xyz/client/add") else {return}
    var request = URLRequest(url: url, timeoutInterval: Double.infinity)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(response!)
      print(String(data: data, encoding: .utf8)!)
    }

    task.resume()
  }
}
