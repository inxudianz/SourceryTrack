//
//  ViewController.swift
//  SourceryTrack
//
//  Created by William William on 05/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let track: TrackingManagerProtocol = TrackingManager()
            .setTracking(for: .external)
            .constructParam(with: .init(key: .name, value: ""),
                            .init(key: .password, value: "pass"),
                            .init(key: .email, value: "email"),
                            .init(key: .rating, value: nil),
                            .init(key: .nested, value: "nested1"))
            .initialize()
        
        track.trackEvent()
        // Do any additional setup after loading the view.
    }


}

