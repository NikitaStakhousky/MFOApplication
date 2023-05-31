//
//  OnboardingRootView.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 11.05.23.
//

import SwiftUI

struct OnboardingView: View {
  @EnvironmentObject private var viewModel: OnboardingViewModel
  
  var body: some View {
    ZStack {
      Color.contentMain
        .ignoresSafeArea()
      VStack {
        TabView(selection: $viewModel.currentStep) {
          ForEach(viewModel.onboardingSteps) { step in
            
            VStack {
              onboardingImage(with: step.image, bundle: .main)
              
              Text(step.title)
                .font(.title)
                .foregroundColor(Color.white)
                .bold()
                .padding(.top, 60)
              
              Text(step.description)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.extraLight)
                .padding(.horizontal, 32)
                .padding(.top, 16)
              
              HStack(spacing: 1) {
                currentStepView()
              }
              .padding(.bottom, 100)
            }
          }
        }
        .allowsHitTesting(false)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        currentButton()
      }
      .fullScreenCover(isPresented: $viewModel.started) {
        FirstLoanView().environmentObject(AuthViewModel())
      }
    }
  }
  
  @ViewBuilder private func onboardingImage(with named: String, bundle: Bundle? = nil) -> some View {
    let image = UIImage(named: named, in: bundle, with: .none)?.withRenderingMode(.alwaysOriginal)
    if viewModel.currentStep == viewModel.onboardingSteps.count - 1 {
      Image(uiImage: image ?? UIImage())
        .resizable()
        .scaledToFill()
        .frame(width: 86, height: 164, alignment: .center)
    } else {
      Image(uiImage: image ?? UIImage())
        .resizable()
        .scaledToFill()
        .frame(width: 170, height: 170, alignment: .center)
    }
  }
  
  @ViewBuilder private func currentStepView() -> some View {
    ForEach(viewModel.onboardingSteps) { step in
      if step.id == viewModel.currentStep {
        Circle()
          .frame(width: 10, height: 5)
          .foregroundColor(Color.accentMain)
      } else {
        Circle()
          .frame(width: 10, height: 5)
          .foregroundColor(Color.gray)
      }
    }
  }
  
  @ViewBuilder private func currentButton() -> some View {
    Button(action: {
      viewModel.continueDidTap()
    }) {
      if viewModel.currentStep == viewModel.onboardingSteps.count - 1 {
        Text(viewModel.continueText())
          .padding(16)
          .frame(maxWidth: .infinity)
          .background(Color.accentMain)
          .cornerRadius(10)
          .padding(.horizontal, 16)
          .foregroundColor(.white)
      } else {
        Text(viewModel.continueText())
          .padding(16)
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 16)
          .foregroundColor(.gray)
      }
    }
  }
}

struct OnboardingRootView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
  }
}
