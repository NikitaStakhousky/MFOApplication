//
//  NewLoanView.swift
//  CreditCenter
//
//  Created by Stakhousky Nikita on 16.05.23.
//

import SwiftUI

struct NewLoanView: View {
  
  @State private var total: Double = 0.0
  @State private var days: Double = 0.0
  
    var body: some View {
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
          Text("Взять новый займ")
            .foregroundColor(.white)
            .font(.system(size: 26, weight: .semibold))
            .padding()
          VStack {
            HStack {
              Text("Вы берете")
                .foregroundColor(.white)
              Spacer()
              Text("\(total, specifier: "%.f")₽")
                .foregroundColor(.white)
            }
            Slider(value: $total, in: 0...130000, step: 5000)
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
          viewResults()
            .padding()
        }
      }
    }
  
  @ViewBuilder private func viewResults() -> some View {
    NavigationLink {
      //AuthenticationView()
    } label: {
      Text("Показать предложения")
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.accentMain)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .foregroundColor(.white)
    }
  }
}

struct NewLoanView_Previews: PreviewProvider {
    static var previews: some View {
        NewLoanView()
    }
}
