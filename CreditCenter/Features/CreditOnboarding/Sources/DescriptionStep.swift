//
//  DescriptionStep.swift
//  CreditCenter
//
//  Created by Nikita Stakhousky on 11.05.23.
//

import Foundation

enum DescriptionStep: CaseIterable, Identifiable {
  case firstStep
  case secondStep
  case thirdStep
  
  var image: String {
    switch self {
    case .firstStep:
     return "image1"
    case .secondStep:
     return "image2"
    case .thirdStep:
     return "image3"
    }
  }
  
  var id: Int {
    switch self {
    case .firstStep:
      return 0
    case .secondStep:
      return 1
    case .thirdStep:
      return 2
    }
  }
  
  var title: String {
    switch self {
    case .firstStep:
      return "Быстрое получение денег"
    case .secondStep:
      return "Простое отслеживание операций"
    case .thirdStep:
      return "Удобный подбор вариантов"
    }
  }
  
  var description: String {
    switch self {
    case .firstStep:
      return "Выберите необходимые сумму и период займа, а приложение покажет лучшие предложения от подходящих организаций"
    case .secondStep:
      return "Выберите необходимые сумму и период займа, а приложение покажет лучшие предложения от подходящих организаций"
    case .thirdStep:
      return "Выберите необходимые сумму и период займа, а приложение покажет лучшие предложения от подходящих организаций"
    }
  }
}
