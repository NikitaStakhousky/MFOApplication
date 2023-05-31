//
//  GlobalTracker.swift
//  CreditCenter
//
//  Created by Maksim Chizhavko on 16.05.23.
//

import Foundation

class GlobalTracker {

    private static let shared = GlobalTracker()

    private let trackingQueue = DispatchQueue(label: "com.global-tracker.tracking-queue", qos: DispatchQoS.background, attributes: .concurrent)

    init() {}

    private var wasConfigured: Bool = false

    var postponedEvents: [TrackableEvent] = []
    var postponedProperties: [TrackableProperty] = []
    private var adapters: [AnalyticsAdapter] = []

    private var log: ((String) -> Void) = { message in
        print(message)
    }
    
    enum LoggingLevel {
        case none, info, verbose
    }
    
    var loggingLevel: LoggingLevel = .none

    func set(adapters: [AnalyticsAdapter]) {
        self.adapters = adapters
    }

    func configureAdapters() {
        trackingQueue.sync {
            self.adapters.forEach { $0.configure() }
            self.wasConfigured = true
            self.postponedEvents.forEach { self.track(event: $0) }
            self.postponedProperties.forEach { self.update(property: $0) }
            self.postponedEvents.removeAll()
            self.postponedProperties.removeAll()
        }
    }

    func resetAdapters() {
        trackingQueue.sync {
            self.adapters.forEach { $0.reset() }
        }
    }

    func track(event: TrackableEvent) {

        if !self.wasConfigured {
            self.postponedEvents.append(event)
            // Should reschedule to be sent after configuration is complete
            return
        }

        trackingQueue.sync {
            self._track(event: event)
        }
    }

    private func _track(event: TrackableEvent) {
        func trackEvent(event: TrackableEvent, tracker: AnalyticsAdapter) {
            if self.loggingLevel == .info {
                log("-[\(tracker.name)]: EVENT TRIGGERED - '\(event.identifier.formatted)'")
            } else if self.loggingLevel == .verbose {
                if event.metadata.count > 0 {
                    let metadata = event.metadata.compactMap { "\($0.key): \($0.value)"}.joined(separator: "\n > ")
                    log("-[\(tracker.name)]: EVENT TRIGGERED - '\(event.identifier.formatted)' \n > \(metadata)")
                } else {
                    log("-[\(tracker.name)]: EVENT TRIGGERED - '\(event.identifier.formatted)' (no meta)")
                }
                
            }

            tracker.track(event: event)
        }

        adapters.forEach { tracker in
            if let rule = tracker.eventTrackingRule {
                let isIncluded = rule.types.contains(where: { type(of: event) == $0 })

                if isIncluded && rule.rule == .allow {
                    trackEvent(event: event, tracker: tracker)
                } else if !isIncluded && rule.rule == .prohibit {
                    trackEvent(event: event, tracker: tracker)
                }
            } else {
                trackEvent(event: event, tracker: tracker)
            }
        }
    }

    func update(property: TrackableProperty) {

        if !self.wasConfigured {
            trackingQueue.async(flags: .barrier) {
                self.postponedProperties.append(property)
            }
            return
        }

        trackingQueue.sync {
            self._update(property: property)
        }
    }

    private func _update(property: TrackableProperty) {

        self.adapters.forEach { tracker in
            let action = {
                tracker.track(property: property)

                if self.loggingLevel == .info {
                    self.log("-[\(tracker.name)]: '\(property.identifier)' UPDATED TO '\(property.trackedValue ?? "nil")'")
                }
            }

            if let rule = tracker.propertyTrackingRule {
                let isIncluded = rule.types.contains(where: { type(of: property) == $0 })

                if isIncluded && rule.rule == .allow {
                    action()
                } else if !isIncluded && rule.rule == .prohibit {
                    action()
                }
            } else {
                action()
            }
        }

        property.generateUpdateEvents().forEach(self._track)
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter
    }()

    // MARK: - Public API
    /// Set adapters to track events to and configure them to start tracking
    class func startTracking(adapters: [AnalyticsAdapter]) {
        shared.set(adapters: adapters)
        shared.configureAdapters()
    }

    class func log(logClosure: @escaping (String) -> Void) {
        shared.log = logClosure
    }

    /// Reset trackers so them set new unregistered user
    class func resetAdapters() {
        shared.resetAdapters()
    }

    /// Track event
    class func track(event: TrackableEvent) {
        shared.track(event: event)
    }

    /// Update property
    class func update(property: TrackableProperty) {
        shared.update(property: property)
    }

    /// Default `.none`
    class var loggingLevel: LoggingLevel {
        get {
            return shared.loggingLevel
        }
        set {
            shared.loggingLevel = newValue
        }
    }
}
