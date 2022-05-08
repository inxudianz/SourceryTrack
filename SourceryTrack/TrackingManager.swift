//
//  TrackingManager.swift
//  SourceryTrack
//
//  Created by William William on 05/05/22.
//

import Foundation

protocol TrackingManagerProtocol {
    func setTracking(for type: TrackingManager.TrackingType) -> TrackingManagerProtocol
    func constructParam(with params: TrackingManager.TrackingParam...) -> TrackingManagerProtocol
    func initialize() -> TrackingManagerProtocol
    func trackEvent()
}

class TrackingManager: TrackingManagerProtocol {
    private var trackingType: TrackingType?
    private var param: [String: Any]?
    
    func setTracking(for type: TrackingType) -> TrackingManagerProtocol {
        trackingType = type
        return self
    }
        
    func constructParam(with params: TrackingParam...) -> TrackingManagerProtocol {
        guard let trackingType = trackingType else {
            return TrackingManager()
        }
        
        let dict: [String: Any] = params.reduce(into: [String: Any]()) {
            $0[$1.key.getRawValue(for: trackingType)] = $1.value
        }
        
        param = dict
        return self
    }
    
    func initialize() -> TrackingManagerProtocol {
        if trackingType == nil {
            assertionFailure("tracking type nil")
        }
        
        if param == nil {
            assertionFailure("param nil")
        }
        
        return self
    }
    
    func trackEvent() {
        guard let json = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) else { return }
        
        let jsonString = String(data: json, encoding: .utf8)
        print(jsonString!)
    }
    
    required init() { }
    
    enum TrackingType {
        case `internal`
        case external
    }
    
    struct TrackingParam {
        let key: TrackingKey
        let value: Any?
        
        init(key: TrackingKey, value: Any?) {
            @TrackingParamValue(key: key) var trackingValue: Any?
            
            trackingValue = value
            self.key = key
            self.value = trackingValue
        }
    }
    
    enum TrackingKey {
        case name
        case email
        case password
        case rating
        case nested
        
        func getRawValue(for type: TrackingType) -> String {
            switch self {
            case .name:
                switch type {
                case .internal:
                    return "name"
                case .external:
                    return "nameExternal"
                }
            case .email:
                return "email"
            case .password:
                return "password"
            case .rating:
                return "rating"
            case .nested:
                return "nested"
            }
        }
    }
    
    @propertyWrapper
    struct TrackingParamValue {
        var key: TrackingKey
        
        private var _wrappedValue: Any?
        var wrappedValue: Any? {
            get {
                return _wrappedValue
            }
            set {
                guard let value: Any = newValue else {
                    _wrappedValue =  Self.getDefaultValue(for: key)
                    return
                }
                
                _wrappedValue = Self.getIntendedValue(for: key, originalValue: value)
            }
        }
        
        init(key: TrackingKey) {
            self.key = key
        }
        
        static func getDefaultValue(for key: TrackingKey) -> String? {
            switch key {
            default:
                return "default"
            }
        }
        
        static func getIntendedValue(for key: TrackingKey, originalValue: Any) -> Any {
            switch key {
            case .password:
                guard let originalValue: String = originalValue as? String else { return originalValue }
                guard let range = originalValue.range(of: originalValue) else { return originalValue }
                return originalValue.replacingCharacters(in: range, with: String(repeating: "*", count: originalValue.count))
            default:
                return originalValue
            }
        }
    }
}

//enum TrackableParam {
//    case name(value: String?)
//    case email(value: String?)
//    case password(value: String?)
//    case rating(value: Float?)
//}

//extension TrackableParam: TrackingParamRequirement {
//    var key: String {
//        switch self {
//        case .name(_):
//            return TrackingKey.name.rawValue
//        case .email(_):
//            return TrackingKey.email.rawValue
//        case .password(_):
//            return TrackingKey.password.rawValue
//        case .rating(_):
//            return TrackingKey.rating.rawValue
//        }
//    }
//
//    var value: String? {
//        switch self {
//        case .name(value: let value):
//            return value
//        case .email(value: let value):
//            return value
//        case .password(value: let value):
//            return value
//        case .rating(value: let value):
//            return String(value ?? .zero)
//        }
//    }
//}
