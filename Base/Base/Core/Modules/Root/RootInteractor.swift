//
//  RootInteractor.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class RootInteractor: RootUseCase {
    
    weak var output: LoginInteractorOutput!

    func checkUserState() {
        ClientService.shared.getUser { (success, _) in
            DispatchQueue.main.async {
                if success != nil {
                    showInController()
                }
                else {
                    showInController() // CHANGE
                }
            }
        }
    }

    func initPlayPusher(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        ClientService.shared.getUser { (success, error) in
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = 0
                let options: AnyObject? = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as AnyObject?
                if UIDevice.current.identifierForVendor != nil {
                    let uuid = UIDevice.current.identifierForVendor!.uuidString
                    print("uuid: \(uuid)")
                    guard let userId = success?.UserId else {
                        PlayPusher.sharedInstance().initPlayPusher(uuid, withClientId: SecureStrings.shared.PlayPusherClientId, withClientSecret: SecureStrings.shared.PlayPusherClientSecret)
                        if (options != nil) {
                            PlayPusher.sharedInstance().handleNotification(launchOptions)
                        }
                        return
                    }
                    PlayPusher.sharedInstance().initPlayPusher(uuid, withClientId: SecureStrings.shared.PlayPusherClientId, withClientSecret: SecureStrings.shared.PlayPusherClientSecret, withUserId: "\(userId)")
                    if (options != nil) {
                        PlayPusher.sharedInstance().handleNotification(launchOptions)
                    }
                }
            }
        }
    }

}
