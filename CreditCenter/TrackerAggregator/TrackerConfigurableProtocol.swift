//
//  TrackerConfigurableProtocol.swift
//  CreditCenter
//
//  Created by Maksim Chizhavko on 16.05.23.
//

import Foundation

protocol TrackerConfigurable: AnyObject {
    /// This is called before anything is tracked to configure each tracker. This is being called on background thread!
    func configure()
    func reset()

    var name: String { get }
}

protocol AnalyticsAdapter: EventTrackable, PropertyTrackable, TrackerConfigurable {}


enum TrackingRule {
    case allow, prohibit
}

// MARK: - Event tracking
protocol EventTrackable {
    var eventTrackingRule: EventTrackingRule? { get }

    func track(event: TrackableEvent)
}


protocol EventIdentifiable {
    var identifier: EventIdentifier { get }
}

protocol MetadataConvertible {
    var metadata: [String: Any] { get }
}



protocol TrackableEvent: MetadataConvertible, EventIdentifiable {}



// MARK: - Property tracking
protocol TrackableValueType { }

protocol TrackableProperty {
    var identifier: String { get }
    var trackedValue: TrackableValueType? { get }

    func generateUpdateEvents() -> [TrackableEvent]
}

protocol PropertyTrackable {
    var propertyTrackingRule: PropertyTrackingRule? { get }

    func track(property: TrackableProperty)
}




