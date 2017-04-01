//
//  Constants.swift
//  
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved..
//

import UIKit
import Foundation
import Alamofire
import SwiftColor
import SDWebImage
import IQKeyboardManagerSwift
import ObjectMapper
import SwiftMessages
import Fabric
import Crashlytics

enum Constants {
    static let imagePlaceholder = "image-placeholder"
}

struct Global {
    static let API_BASE_DOMAIN = "http://www.google.com"
    static let API_VERSION = "v1"
    static let API_CLIENT_ID = "client-id"
    static let API_CLIENT_SECRET = "client-secret"
    static let API_ACCESS_TOKEN = "AccessToken"
    static let APP_FIRST_LOAD = "AppFirstLoad"
    static let LOGIN_EMAIL_KEY = "Email"
    static let LOGIN_PASSWORD_KEY = "LoginPassword"
    static let PLAYPUSHER_CLIENT_ID = ""
    static let PLAYPUSHER_CLIENT_SECRET = ""
    static var APP_REALM_VERSION: Int = 1
}

struct UI {
    static let contentWidth: CGFloat = 280.0
    static let dialogHeightSinglePermission: CGFloat = 260.0
    static let dialogHeightTwoPermissions: CGFloat = 360.0
    static let dialogHeightThreePermissions: CGFloat = 460.0
    static let maxWidth: CGFloat = 10000.0
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.width)
    static let SCREEN_MIN_LENGTH = min(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.height)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MIN_LENGTH == 736.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MIN_LENGTH == 1024.0
}

func uniq<S: Sequence, E: Hashable>(source: S) -> [E] where E==S.Iterator.Element {
    var seen: [E:Bool] = [:]
    return source.filter { seen.updateValue(true, forKey: $0) == nil }
}

let app = UIApplication.shared.delegate as! AppDelegate

func forcePortrait() {
    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
}

func alert(vc: UIViewController, message: String?, title: String?) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert) -> Void in
    }))
    DispatchQueue.main.async {
        vc.present(ac, animated: true, completion: nil)
    }
}

func setupSplashController() {
    let splashController = UIViewController()
    splashController.view.frame = UIScreen.main.bounds
    splashController.view.backgroundColor = Color(hexString: "#FFFFFF")

    let bg = UIImageView(frame: UIScreen.main.bounds)
    bg.image = UIImage()
    bg.contentMode = .scaleAspectFill
    //splashController.view.addSubview(bg)

    let imageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 180) / 2, y: ((UIScreen.main.bounds.height - 180) / 2), width: 180, height: 180))
    imageView.image = UIImage()
    imageView.contentMode = .scaleAspectFit
    //splashController.view.addSubview(imageView)

    let actView = UIActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.size.width - 30) / 2, y: ((UIScreen.main.bounds.height - 30) / 2) + 120, width: 30, height: 30))
    actView.activityIndicatorViewStyle = .white
    actView.startAnimating()

    splashController.view.addSubview(actView)

    app.window = UIWindow(frame: UIScreen.main.bounds)
    app.window?.makeKeyAndVisible()
    app.window?.rootViewController = splashController
}

func setupRootController() {
    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    UserDefaults.standard.synchronize()
    UIApplication.shared.statusBarStyle = app.statusBarStyle
    UIApplication.shared.setStatusBarHidden(false, with: .none)
}

func customNavbar(vc: UIViewController) -> UINavigationController {
    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.barTintColor = UIColor.white
    nav.navigationBar.barStyle = .default
    nav.navigationBar.titleTextAttributes = [NSFontAttributeName: defaultBoldFont(size: 17), NSForegroundColorAttributeName: UIColor.darkGray]
    if nav.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
        nav.interactivePopGestureRecognizer!.isEnabled = true
        nav.interactivePopGestureRecognizer!.delegate = nil
    }
    return nav
}

func showNoConnectionUX(message: String?) {
    let view = MessageView.viewFromNib(layout: .CardView)
    view.configureTheme(.error, iconStyle: .light)
    view.configureDropShadow()
    view.button?.isHidden = true
    var msg = "You appear to be offline. Please check your internet connection."
    if message != nil {
        msg = message!
    }
    view.configureContent(title: "Warning", body: msg)
    var config = SwiftMessages.defaultConfig
    config.duration = .forever
    config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
    SwiftMessages.show(config: config, view: view)
}

func removeNoConnectionUX() {
    SwiftMessages.hide()
}

func registerForPush(userId: String) {
    if !app.pushRegisterInProcess {
        app.pushRegisterInProcess = true

        let action : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        action.title = ""
        action.identifier = ""
        action.activationMode = UIUserNotificationActivationMode.foreground
        action.isAuthenticationRequired = false

        let category : UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        category.setActions([action], for: UIUserNotificationActionContext.default)
        category.identifier = ""

        let categories = NSSet(object: category) as Set

        PlayPusher.sharedInstance().requestPermission(userId, withCategories: categories)
    }
}

func showInController() {
    DispatchQueue.main.async {
        RootRouter().presentTabBar(in: app.window)
    }
}

func showOutController() {
    DispatchQueue.main.async {
        RootRouter().presentLoginScreen(in: app.window)
    }
}

func setupReachability() {
    NotificationCenter.default.addObserver(app.self, selector: #selector(app.reachabilityChanged(note:)), name: NSNotification.Name(rawValue: "kNetworkReachabilityChangedNotification"), object: nil)
    app.hostReachability = Reachability(hostName: Global.API_BASE_DOMAIN)
    app.hostReachability.startNotifier()
    updateInterfaceWithReachability(reachability: app.hostReachability)
    app.internetReachability = Reachability.forInternetConnection()
    app.internetReachability.startNotifier()
    updateInterfaceWithReachability(reachability: app.internetReachability)
    if app.internetConnected {
        removeNoConnectionUX()
    }
    else {
        showNoConnectionUX(message: nil)
    }
}

func updateInterfaceWithReachability(reachability: Reachability) {
    if reachability == app.hostReachability {
        let connectionRequired = reachability.connectionRequired()
        if connectionRequired {
            print("Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.")
            app.hostConnected = true
        }
        else {
            print("Cellular data network is active.\nInternet traffic will be routed through it.")
            app.hostConnected = false
        }
    }
    if reachability == app.internetReachability {
        app.internetConnected = true
        let networkStatus = reachability.currentReachabilityStatus()
        switch networkStatus {
        case NotReachable:
            print("Access Not Available")
            app.internetConnected = false
        case ReachableViaWWAN:
            print("Reachable WWAN")
            app.internetConnected = true
        case ReachableViaWiFi:
            print("Reachable WiFi")
            app.internetConnected = true
        default:
            print("Unknown")
            app.internetConnected = true
        }
    }
    if app.internetConnected {
        removeNoConnectionUX()
    }
    else {
        showNoConnectionUX(message: nil)
    }
}

func checkInternetConnection() {
    if app.internetConnected {
        removeNoConnectionUX()
    }
    else {
        removeNoConnectionUX()
        showNoConnectionUX(message: nil)
    }
}

func initRootControllerWithVendors(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
    RootInteractor().initPlayPusher(launchOptions: launchOptions)
    Fabric.sharedSDK().debug = true
    Fabric.with([Crashlytics.self])
    setupSplashController()
    setupRootController()
}

func applicationDidStart() {
    setupReachability()
    app.pushRegisterInProcess = false
    RootInteractor().checkUserState()
}

func applicationDidEnd() {
    app.hostReachability.stopNotifier()
    app.internetReachability.stopNotifier()
    NotificationCenter.default.removeObserver(app.self, name: NSNotification.Name(rawValue: "kNetworkReachabilityChangedNotification"), object: nil)
}

func defaultRegularFont(size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func defaultMediumFont(size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

func defaultBoldFont(size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

