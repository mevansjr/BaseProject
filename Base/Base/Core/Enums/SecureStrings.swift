//
//
//  SecureStrings.swift
//
//  Created by Mark Evans on 2/22/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

@objc public class SecureStrings: NSObject {
    
    let ApiHost = "h".t.t.p.s.colon.forward_slash.forward_slash.w.w.w.dot.g.o.o.g.l.e.dot.c.o.m
    let ApiLiveHost = "h".t.t.p.s.colon.forward_slash.forward_slash.w.w.w.dot.g.o.o.g.l.e.dot.c.o.m
    let ApiDevHost = "h".t.t.p.s.colon.forward_slash.forward_slash.w.w.w.dot.g.o.o.g.l.e.dot.c.o.m
    let ApiVersion = "v"._1
    let ApiClientId = "client-id"
    let ApiClientSecret = "client-secret"
    let PlayPusherClientId = "Empty"
    let PlayPusherClientSecret = "Empty"
    let GoogleAnalyticsKey = "Empty"

    static let shared: SecureStrings = {
        let instance = SecureStrings()
        return instance
    }()

}
