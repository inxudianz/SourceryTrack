//
//  TrackingVC.swift
//  SourceryTrack
//
//  Created by William William on 07/05/22.
//

import Foundation

protocol TrackingVCProtocol: AutoTracking {
// sourcery: eventName = "event name track"
    func track(name: String,
               email: String,
               password: String,
               rating: Float)

// sourcery: eventName = "event name track amplitude"
    func trackAmplitude(
        name: String,
        email: String,
        password: String
    )
}
//
//final class TrackingVC: TrackingVCProtocol {
//    
//}


protocol AutoEquatable {}

struct Person: AutoEquatable {
    var age: Int
    var name: String
}

protocol AutoTracking {}
