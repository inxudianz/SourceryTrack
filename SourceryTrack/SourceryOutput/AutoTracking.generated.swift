// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: TrackingVCProtocol Auto Tracking

// remove
final class TrackingVCProtocolAuto: TrackingVCProtocol {
    func track(
        name: String
        email: String
        password: String
        rating: Float
    ) {
        let trackingManager: TrackingManager = TrackingManager()
            .setTracking(for: .bigQuery)
            .constructParam(
                with:
                TrackingManager.TrackingParam(key: .name, value: name),
                TrackingManager.TrackingParam(key: .email, value: email),
                TrackingManager.TrackingParam(key: .password, value: password),
                TrackingManager.TrackingParam(key: .rating, value: rating)
            )
        trackingManager.trackEvent()
    }
}
    func trackAmplitude(
        name: String
        email: String
        password: String
    ) {
        let trackingManager: TrackingManager = TrackingManager()
            .setTracking(for: .amplitude)
            .constructParam(
                with:
                TrackingManager.TrackingParam(key: .name, value: name),
                TrackingManager.TrackingParam(key: .email, value: email),
                TrackingManager.TrackingParam(key: .password, value: password)
            )
        trackingManager.trackEvent()
    }
}
}
