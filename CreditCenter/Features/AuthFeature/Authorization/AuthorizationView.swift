//
//  AuthorizationView.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 12.05.23.
//

import SwiftUI

struct AuthorizationView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  @State private var password: String = ""
  
    var body: some View {
      ZStack {
        Color.contentMain
          .ignoresSafeArea()
        VStack(alignment: .leading) {
          Text("Авторизация")
            .font(.system(size: 21, weight: .semibold))
            .foregroundColor(.white)
            .padding()
          VStack {
            textFieldAuthorization()
            HStack {
              Spacer()
              rememberPassword()
            }
          }
          Spacer()
          authorizationButton()
            .padding(.top, 44)
          haveNotAccount()
        }
      }
    }
  
  @ViewBuilder private func authorizationButton() -> some View {
    NavigationLink {
    LoadView()
    } label: {
      Text("Войти")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.accentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
  
  @ViewBuilder private func rememberPassword() -> some View {
    Button {
      //
    } label: {
      Text("Забыли пароль?")
        .foregroundColor(.white)
    }.padding()

  }
  
  @ViewBuilder private func haveNotAccount() -> some View {
    NavigationLink {
  
    } label: {
      Text("Нет аккаунта?")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.contentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
  
  @ViewBuilder private func textFieldAuthorization() -> some View {
    VStack {
      ZStack {
        TextField("", text: $viewModel.phoneNumber)
          .modifier(TextFieldsModifier())
          .placeholder(when: viewModel.phoneNumber.isEmpty, placeholder: {
            HStack {
              Text("Номер телефона").foregroundColor(.white)
              Spacer()
              Image("userPhone")
                .resizable()
                .renderingMode(.template)
                .frame(width: 18, height: 18)
                .foregroundColor(.white)
            }.padding(.all, 30)
          })
      }
      ZStack {
        SecureField("", text: $password)
          .modifier(TextFieldsModifier())
          .placeholder(when: password.isEmpty, placeholder: {
            HStack {
              Text("Пароль").foregroundColor(.white)
              Spacer()
              Image("userPassword")
                .resizable()
                .renderingMode(.template)
                .frame(width: 18, height: 18)
                .foregroundColor(.white)
            }.padding(.all, 30)
          })
      }
    }
  }
}
