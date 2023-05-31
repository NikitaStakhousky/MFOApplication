//
//  FirstLoanView.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 12.05.23.
//

import SwiftUI

struct FirstLoanView: View {
  @State private var total: Double = 0.0
  @State private var days: Double = 0.0
  
  @EnvironmentObject var viewModel: AuthViewModel
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.contentMain
          .ignoresSafeArea()
        VStack(alignment: .leading) {
          HStack {
            Image("logo")
              .resizable()
              .scaledToFit()
              .frame(width: 40, height: 42)
            Text("Credit Center")
              .foregroundColor(.white)
              .font(.system(size: 23, weight: .semibold))
          }.padding()
          Text("Первый займ - под 0%")
            .foregroundColor(.white)
            .font(.system(size: 26, weight: .semibold))
            .padding()
          VStack {
            HStack {
              Text("Вы берете")
                .foregroundColor(.white)
              Spacer()
              Text("\(viewModel.loanAmount, specifier: "%.f")₽")
                .foregroundColor(.white)
            }
            Slider(value: $viewModel.loanAmount, in: 0...130000, step: 5000)
          }.padding()
          
          VStack {
            HStack {
              Text("На срок")
                .foregroundColor(.white)
              Spacer()
              Text("\(days, specifier: "%.f") дней")
                .foregroundColor(.white)
            }
            Slider(value: $days, in: 0...240, step: 1.0)
          }.padding()
          Spacer()
          getValueButton()
          signIn()
        }
      }
    }
  }
  
  @ViewBuilder private func getValueButton() -> some View {
    NavigationLink {
      AuthenticationView().environmentObject(AuthViewModel())
    } label: {
      Text("Получить деньги")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.accentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
  
  @ViewBuilder private func signIn() -> some View {
    NavigationLink {
      AuthorizationView().environmentObject(AuthViewModel())
    } label: {
      Text("Войти")
        .padding(16)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
}


struct FirstLoanView_Previews: PreviewProvider {
  static var previews: some View {
    FirstLoanView()
  }
}
