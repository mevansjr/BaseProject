//
//  AppDelegate.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftColor
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
@objc class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    // MARK: Application Properties

    var window: UIWindow?
    var internetReachability = Reachability()
    var hostReachability = Reachability()
    var tabBarController = UITabBarController()
    var statusBarStyle = UIStatusBarStyle.lightContent
    var pushRegisterInProcess = false
    var hostConnected = true
    var internetConnected = true
    var permissionsHasShown = false

    // MARK: Application Delegate Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initRootControllerWithVendors(launchOptions: launchOptions)
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        applicationDidEnd()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        applicationDidStart()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return true
    }

    // MARK: Playpusher Methods

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PlayPusher.sharedInstance().registerDevice(deviceToken as Data!)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        PlayPusher.sharedInstance().registerFailure()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if application.applicationState != UIApplicationState.active {
            PlayPusher.sharedInstance().handleNotification(userInfo)
        }
    }

    // MARK: TabBar Methods

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        checkInternetConnection()
    }

    // MARK: Reachability Methods

    func reachabilityChanged(note: NSNotification) {
        if let curReach = note.object as? Reachability {
            updateInterfaceWithReachability(reachability: curReach)
        }
    }
    
}
