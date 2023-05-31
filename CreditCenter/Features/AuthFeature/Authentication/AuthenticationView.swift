//
//  AuthenticationView.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 12.05.23.
//

import SwiftUI

struct AuthenticationView: View {
  @State private var password: String = ""
  @State private var agreement: Bool = false
  
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      ZStack {
        Color.contentMain
          .ignoresSafeArea()
        VStack(alignment: .leading) {
          Text("Зарегестрироваться")
            .font(.system(size: 21, weight: .semibold))
            .foregroundColor(.white)
            .padding()
          VStack {
            textFieldsAuthentication()
            HStack(spacing: 20) {
             agreementPersonalData()
              Text("Я даю согласие на обработку моих персональных данных")
                .foregroundColor(.white)
            }
          }
          Spacer()
          authenticationButton()
            .padding(.top, 44)
          nextWithoutAuthentication()
        }
      }
    }
  
  @ViewBuilder private func authenticationButton() -> some View {
    NavigationLink {
    LoadView()
        .task {
          viewModel.sendData()
        }
    } label: {
      Text("Зарегестрироваться")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.accentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
  
  @ViewBuilder private func nextWithoutAuthentication() -> some View {
    NavigationLink {
  
    } label: {
      Text("Продолжить без регистрации")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.contentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
  
  
  @ViewBuilder private func textFieldsAuthentication() -> some View {
    VStack(spacing: -20) {
      ZStack {
        TextField("", text: $viewModel.name)
            .modifier(TextFieldsModifier())
            .placeholder(when: viewModel.name.isEmpty, placeholder: {
              HStack {
                Text("Имя").foregroundColor(.white)
                Spacer()
                Image("userName")
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 18, height: 18)
                  .foregroundColor(.white)
              }.padding(.all, 30)
            })
      }
      ZStack {
        TextField("", text: $viewModel.email)
            .modifier(TextFieldsModifier())
            .placeholder(when: viewModel.email.isEmpty, placeholder: {
              HStack {
                Text("Электронная почта").foregroundColor(.white)
                Spacer()
                Image("userEmail")
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 18, height: 18)
                  .foregroundColor(.white)
              }.padding(.all, 30)
            })
      }
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
          TextField("", text: $password)
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
  
  @ViewBuilder private func agreementPersonalData() -> some View {
    Button {
      agreement.toggle()
    } label: {
      if agreement {
        Image(systemName: "checkmark")
          .padding(16)
          .frame(width: 20, height: 20)
          .background(Color.accentMain)
          .cornerRadius(6)
          .padding(.horizontal, 16)
          .foregroundColor(.white)
      } else {
        Image(systemName: "")
          .padding(16)
          .cornerRadius(6)
          .foregroundColor(.white)
          .frame(width: 20, height: 20)
          .overlay(
            RoundedRectangle(cornerRadius: 6)
              .stroke(Color.gray, lineWidth: 2)
          )
          .padding(.horizontal, 16)
      }
    }
  }
}
