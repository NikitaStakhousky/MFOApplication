//
//  OnboardingViewModel.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 11.05.23.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
  let onboardingSteps = DescriptionStep.allCases
  @Published var currentStep = 0
  @Published var started = false

  
  func skipDidTap() {
    currentStep = onboardingSteps.count - 1
  }
  
  func continueText() -> String {
    if currentStep < onboardingSteps.count - 1 {
      return "Пропустить"
    } else {
      return "Все понятно"
    }
  }
  
  func continueDidTap() {
    if currentStep < onboardingSteps.count - 1 {
      currentStep += 1
    } else {
      started.toggle()
    }
  }
}
