//
//  BaseExtension.swift
//  Base
//
//  Created by Mark Evans on 3/31/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation
import Alamofire

extension Dictionary {
    func projectConfigPlist() -> [String: Any] {
        if let path = Bundle.main.path(forResource: "ProjectConfiguration", ofType: "plist") {
            if let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] {
                return dictionary
            }
        }
        return [:]
    }
}

extension UIViewController {
    func titleFromPlist() -> String {
        let parsed = self.className
        let replaced = parsed.replacingOccurrences(of: "ViewController", with: "")

        let key = "\(replaced.lowercased())NavigationTitle"
        print("key: \(key)")

        guard let plist = Constants.shared.plist.Titles else {
            return ""
        }
        if let title = plist[key] {
            return title
        }
        return ""
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension String {

    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func isAlphaNumeric() -> Bool {
        let uc = NSCharacterSet.alphanumerics.inverted
        return self.rangeOfCharacter(from: uc) == nil
    }

    func isAlphaOnly() -> Bool {
        let alphaSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let uc = alphaSet.inverted
        return self.rangeOfCharacter(from: uc) == nil
    }
}

extension Date {
    func timeAgo(anotherDate: Date) -> String {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: anotherDate, to: Date())
        let days = components.day
        let hours = components.hour
        let minutes = components.minute
        let seconds = components.second
        if days! >= 1 {
            var daysString = "days"
            if days == 1 {
                daysString = String(daysString.characters.dropLast())
            }
            return "\(String(describing: days!)) \(daysString) ago"
        }
        else if hours! < 24 && hours! >= 1 {
            var hoursString = "hours"
            if hours == 1 {
                hoursString = String(hoursString.characters.dropLast())
            }
            return "\(String(describing: hours!)) \(hoursString) ago"
        }
        else if minutes! < 60 && minutes! > 0 {
            var minString = "minutes"
            if minutes == 1 {
                minString = String(minString.characters.dropLast())
            }
            return "\(String(describing: minutes!)) \(minString) ago"
        }
        if seconds! < 60 && seconds! > 0 {
            var secString = "seconds"
            if seconds == 1 {
                secString = String(secString.characters.dropLast())
            }
            return "Just Now"
        }
        return ""
    }
}

extension String {
    func appVersion() -> String {
        var version = ""
        if Bundle.main.infoDictionary != nil {
            if Bundle.main.infoDictionary!["CFBundleVersion"] != nil {
                if let v = Bundle.main.infoDictionary!["CFBundleVersion"]! as? String {
                    version = v
                }
            }
        }
        return version
    }

    func getServicePath(urlRequest: URLRequest) {
        guard let u = urlRequest.url?.absoluteString else {
            return
        }
        let url = URL(string: u)!
        let urlRequest = URLRequest(url: url)
        do {
            let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
            if encodedURLRequest.url != nil {
                print("servicepath: \(encodedURLRequest.url!.absoluteString)")
            }
        } catch _ {
            print("servicepath: \(String().encode(string: u))")
        }
    }

    func getHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["Platform"] = "ios"
        headers["Content-Type"] = "application/json"
        headers["client-id"] = String().currentApiClientId()
        headers["client-secret"] = String().currentApiClientSecret()
        headers["AppVersion"] = String().appVersion()
        return headers
    }

    func encode(string: String) -> String {
        let customAllowedSet = NSCharacterSet.urlQueryAllowed
        return string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
    }
}

extension Array {
    func filterDuplicates( includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}

extension UINavigationController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if visibleViewController != nil {
            return (visibleViewController?.supportedInterfaceOrientations)!
        }
        return UIInterfaceOrientationMask.all
    }
}

extension UITabBarController {
    override open var shouldAutorotate: Bool {
        if selectedViewController != nil {
            return (selectedViewController?.shouldAutorotate)!
        }
        return false
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if selectedViewController != nil {
            return (selectedViewController?.supportedInterfaceOrientations)!
        }
        return UIInterfaceOrientationMask.all
    }
}
