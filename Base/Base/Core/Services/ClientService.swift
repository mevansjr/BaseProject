//
//  ClientService.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Alamofire
import SDWebImage

public class ClientService {

    // MARK: Properties

    var currentUser: User?
    var manager = SessionManager()
    var oauthHandler: ClientOAuthHandler?

    // MARK: Shared Instance

    static let shared: ClientService = {
        let instance = ClientService()
        instance.setupManager()
        return instance
    }()

    // MARK: Setup Methods

    func setupManager() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = String().getHeaders()
        self.manager = Alamofire.SessionManager(configuration: configuration)
        self.oauthHandler = self.getClientOAuthHandler()
        self.manager.adapter = self.oauthHandler
        self.manager.retrier = self.oauthHandler
    }

    // MARK: OAuth Methods

    func loginUser(username: String, password: String, completion: @escaping (_ success: User?, _ error: NSError?) -> ()) {
        DispatchQueue(label: "background", qos: .background).async {
            var newUser: User?
            self.manager.request(ClientRouter.loginUser(username, password: password))
                .validate(statusCode: 200..<300).responseString(completionHandler: { (response) in
                    switch response.result {
                    case .success(let json):
                        UserDefaults.standard.set(username, forKey: Constants.loginUsernameKey)
                        UserDefaults.standard.set(password, forKey: Constants.loginPasswordKey)
                        UserDefaults.standard.synchronize()

                        self.oauthHandler = self.saveTokenAndRetreiveOAuthHandler(json)
                        self.manager.adapter = self.oauthHandler
                        self.manager.retrier = self.oauthHandler

                        self.getUser(completion: { (user, err) in
                            if user != nil {
                                newUser = user!
                                DispatchQueue.main.async {
                                    completion(newUser, nil)
                                }
                            }
                            else {
                                DispatchQueue.main.async {
                                    completion(nil, err)
                                }
                            }
                        })
                    default:
                        print("")
                    }
            }).responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(nil, self.handleError(response: response, error: error as NSError))
                    }
                default:
                    print("")
                }
            }
        }
    }

    func logoutUser(completion: @escaping (_ success: Bool) -> ())  {
        DispatchQueue.main.async {
            self.currentUser = nil
            SDImageCache.shared().clearMemory()
            SDImageCache.shared().clearDisk()
            self.clearTokenAndOAuthHandler()
            completion(true)
        }
    }

    // MARK: Client Methods - User

    func getUser(completion: @escaping (_ success: User?, _ error: NSError?) -> ()) {
       DispatchQueue(label: "background", qos: .background).async {
            var user: User?
            self.manager.request(ClientRouter.getUser())
                .validate(statusCode: 200..<300)
                .responseString(completionHandler: { (response) in
                    switch response.result {
                    case .success(let json):
                        user = Mapper<User>().map(JSONString: json)

                        DispatchQueue.main.async {
                            self.currentUser = user
                            completion(user, nil)
                        }
                    default:
                        print("")
                    }
                })
                .responseJSON { (response) in
                    switch response.result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(nil, self.handleError(response: response, error: error as NSError))
                        }
                    default:
                        print("")
                    }
                }
        }
    }

    // MARK: Error Handling Methods

    func handleError(response: DataResponse<Any>?, error: NSError) -> NSError? {
        if !Constants.shared.internetConnected {
            let err = NSError(domain: "The Internet connection appears to be offline.", code: 900, userInfo: nil)
            return err
        }
        guard let errorResponse = response?.response else {
            return error
        }
        var message = ""
        guard let msg = errorResponse.allHeaderFields["Message"] else {
            let err = NSError(domain: "Internal Server Error", code: 500, userInfo: nil)
            return err
        }
        if msg is String {
            message = msg as! String
        }
        else {
            return error
        }
        return NSError(domain: message, code: errorResponse.statusCode, userInfo: nil)
    }
    
}
