//
//  Extension+TrackerAggregator.swift
//  CreditCenter
//
//  Created by Stakhousky Nikita on 16.05.23.
//

import Foundation

extension TrackerConfigurable {
    var name: String {
        return String(describing: type(of: self))
    }

    func reset() {}
}

extension AnalyticsAdapter {
    func shouldTrackEvent(_ event: TrackableEvent) -> Bool {
        
        guard let rule = eventTrackingRule else {
            return true
        }
        
        let isIncluded = rule.types.contains(where: { type(of: event) == $0 })

        if (isIncluded && rule.rule == .allow) || (!isIncluded && rule.rule == .prohibit) {
            return true
        } else {
            return false
        }
    }
}

// Event triggering shortcut
extension TrackableEvent {
    func trigger() {
        GlobalTracker.track(event: self)
    }
}

// Property update shortcut
extension TrackableProperty {
    func update() {
        GlobalTracker.update(property: self)
    }
}

extension EventIdentifier {
    func underscoredLowercased() -> String {
        if let label = label {
            return "\(object)_\(action)_\(label)".lowercased().replacingOccurrences(of: " ", with: "_")
        } else {
            return "\(object)_\(action)".lowercased().replacingOccurrences(of: " ", with: "_")
        }
    }
}

extension EventTrackable {
    var eventTrackingRule: EventTrackingRule? {
        return nil
    }
}

extension MetadataConvertible {
    var metadata: [String: Any] {
        [:]
    }
}

extension String: TrackableValueType {}
extension Bool: TrackableValueType {}
extension Int: TrackableValueType {}
extension Double: TrackableValueType {}

extension TrackableProperty {
    func generateUpdateEvents() -> [TrackableEvent] {
        return []
    }
}

extension PropertyTrackable {
    var propertyTrackingRule: PropertyTrackingRule? {
        return nil
    }
}

extension TrackableValueType {
    var stringValue: String {
        switch self {
        case let string as String:
            return string
        case let int as Int:
            return String(int)
        case let bool as Bool:
            return bool ? "true" : "false"
        case let double as Double:
            return String(double)
        default:
            return "unsupported_value"
        }
    }
}
