//
//  PopupForSubscribeView.swift
//  CreditCenter
//
//  Created by Nikita Stshovsky on 31.05.2023.
//

import SwiftUI
import PopupView

struct PopupForSubscribeView: View {
    var url: URL
    var body: some View {
        ZStack {
            Color.contentMain
                .ignoresSafeArea()
            VStack {
                Text("Подпишитесь на наш телеграм канал чтобы получить бонусы!")
                    .foregroundColor(.blue.opacity(0.8))
                    .padding(.all, 10)
                subscribeButton(url: url)
                    .padding(.top, 140)
            }
        }.frame(width: 300, height: 300)
         .cornerRadius(15)
    }
    
    @ViewBuilder private func subscribeButton(url: URL) -> some View {
       
        Link(destination: url) {
            ZStack {
                HStack(spacing: 6) {
                    Text("Подписаться!")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                    Image(systemName: "star.bubble")
                        .font(.system(size: 10, weight: .light))
                    // .rotation3DEffect(Angle(degrees: 20), axis: (x: 10, y: -10, z: 0))
                        .foregroundColor(.white)
                }.padding()
            }
//            .frame(width: 20, height: 20)
            .background(
                ZStack {
                    Rectangle()
                        .fill(Color.contentMain)
                        .frame(width: 120, height: 60)
                        .cornerRadius(20)
                        .shadow(color: .accentMain, radius: 8, x: -4, y: -8)
                }
            )
        }

    }
}
