//
//  NotificationService.swift
//  CreditCenterNotificationServiseExtension
//
//  Created by Stakhousky Nikita on 23.05.23.
//

import UserNotifications
import OneSignal

class NotificationService: UNNotificationServiceExtension {
  var contentHandler: ((UNNotificationContent) -> Void)?
  var receivedRequest: UNNotificationRequest!
  var bestAttemptContent: UNMutableNotificationContent?
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    self.receivedRequest = request
    self.contentHandler = contentHandler
    self.bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
    if let bestAttemptContent = bestAttemptContent {
      OneSignal.didReceiveNotificationExtensionRequest(self.receivedRequest, with: self.bestAttemptContent)
      contentHandler(bestAttemptContent)
    }
    OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
    bestAttemptContent?.body = "[Modified]" + bestAttemptContent!.body
    OneSignal.didReceiveNotificationExtensionRequest(self.receivedRequest, with: bestAttemptContent, withContentHandler: self.contentHandler)
  }
  
  override func serviceExtensionTimeWillExpire() {
    if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
      OneSignal.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
      contentHandler(bestAttemptContent)
    }
  }
}
