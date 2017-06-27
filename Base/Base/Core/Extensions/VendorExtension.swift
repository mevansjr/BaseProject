//
//  VendorExtension.swift
//  Base
//
//  Created by Mark Evans on 6/27/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

extension String {
    func googleAnalyticsKey() -> String {
        guard let key = Constants.shared.plist.Vendors?.GoogleAnalytics?.key else {
            return ""
        }
        return key
    }

    func playPusherClientId() -> String {
        guard let clientId = Constants.shared.plist.Vendors?.PlayPusher?.clientId else {
            return ""
        }
        return clientId
    }

    func playPusherClientSecret() -> String {
        guard let clientSecret = Constants.shared.plist.Vendors?.PlayPusher?.clientSecret else {
            return ""
        }
        return clientSecret
    }
}
