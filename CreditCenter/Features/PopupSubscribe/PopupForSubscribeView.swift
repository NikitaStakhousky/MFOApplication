//
//  PopupForSubscribeView.swift
//  CreditCenter
//
//  Created by Nikita Stshovsky on 31.05.2023.
//

import SwiftUI
import PopupView

struct PopupForSubscribeView: View {
   
    var body: some View {
        ZStack {
            Color.contentMain
                .ignoresSafeArea()
            VStack {
                Text("Hello")
                    .foregroundColor(.white)
            }
        }.frame(width: 300, height: 300)
         .cornerRadius(15)
    }
}

struct PopupForSubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        PopupForSubscribeView()
    }
}
