//
//  EventTrackingRule.swift
//  CreditCenter
//
//  Created by Stakhousky Nikita on 16.05.23.
//

import Foundation

struct EventIdentifier {
    let object: String
    let action: String
    let label: String?

    init(object: String, action: String, label: String? = nil) {
        self.object = object
        self.action = action
        self.label = label
    }

    var formatted: String {
        if let label = label {
            return "\(object): \(action) - \(label)"
        } else {
            return "\(object): \(action)"
        }
    }
}

struct EventTrackingRule {
    let rule: TrackingRule
    let types: [TrackableEvent.Type]

    init(_ rule: TrackingRule, types: [TrackableEvent.Type]) {
        self.rule = rule
        self.types = types
    }
}

struct PropertyTrackingRule {
    let rule: TrackingRule
    let types: [TrackableProperty.Type]

    init(_ rule: TrackingRule, types: [TrackableProperty.Type]) {
        self.rule = rule
        self.types = types
    }
}
