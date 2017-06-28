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
            return SecureStrings.shared.GoogleAnalyticsKey
        }
        return key
    }

    func playPusherClientId() -> String {
        guard let clientId = Constants.shared.plist.Vendors?.PlayPusher?.clientId else {
            guard let isDevEnvironment = Constants.shared.plist.API?.isDevEnvironment else {
                return SecureStrings.shared.PlayPusherClientId
            }
            return (isDevEnvironment) ? SecureStrings.shared.PlayPusherClientId : SecureStrings.shared.PlayPusherClientIdDev
        }
        return clientId
    }

    func playPusherClientSecret() -> String {
        guard let clientSecret = Constants.shared.plist.Vendors?.PlayPusher?.clientSecret else {
            guard let isDevEnvironment = Constants.shared.plist.API?.isDevEnvironment else {
                return SecureStrings.shared.PlayPusherClientSecret
            }
            return (isDevEnvironment) ? SecureStrings.shared.PlayPusherClientSecret : SecureStrings.shared.PlayPusherClientSecretDev
        }
        return clientSecret
    }
}
