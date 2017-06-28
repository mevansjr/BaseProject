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
import Branch

class RootInteractor: RootUseCase {
    
    weak var output: LoginInteractorOutput!

    func checkUserState() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ClientService.shared.getUser { (success, _) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if success != nil {
                Constants.shared.showInController()
            }
            else {
                Constants.shared.showOutController()
            }
        }
    }

    func initPlayPusher(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        ClientService.shared.getUser { (success, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIApplication.shared.applicationIconBadgeNumber = 0
            let options: AnyObject? = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as AnyObject?
            if UIDevice.current.identifierForVendor != nil {
                let uuid = UIDevice.current.identifierForVendor!.uuidString
                guard let userId = success?.UserId else {
                    PlayPusher.sharedInstance().initPlayPusher(uuid, withClientId: String().playPusherClientId(), withClientSecret: String().playPusherClientSecret())
                    if (options != nil) {
                        PlayPusher.sharedInstance().handleNotification(launchOptions)
                    }
                    print("uuid: \(uuid)")
                    return
                }
                PlayPusher.sharedInstance().initPlayPusher(uuid, withClientId: String().playPusherClientId(), withClientSecret: String().playPusherClientSecret(), withUserId: "\(userId)")
                if (options != nil) {
                    PlayPusher.sharedInstance().handleNotification(launchOptions)
                }
                print("uuid: \(uuid)")
            }
        }
    }

    func initBranchIO(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        Branch.getInstance()?.initSession(launchOptions: launchOptions, automaticallyDisplayDeepLinkController: true, deepLinkHandler: { params, error in
            if error == nil {
                print("params: %@", params?.description as Any)
            }
        })
    }

    func handleDeeplink(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) {
        Branch.getInstance().application(app,
                                         open: url,
                                         options:options
        )
    }

    func continueActivity(_ userActivity: NSUserActivity) {
        Branch.getInstance().continue(userActivity)
    }

}
