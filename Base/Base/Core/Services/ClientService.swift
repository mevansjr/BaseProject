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

@objc public class ClientService: NSObject {

    // MARK: Properties

    var currentUser: User?
    var manager = SessionManager()

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
        // self.manager.adapter = ClientAccessTokenAdapter(accessToken: "") // Non-OAuth Token Adapter
        self.manager.adapter = ClientOAuthHandler(clientID: SecureStrings.shared.ApiClientId, baseURLString: SecureStrings.shared.ApiHost, accessToken: "", refreshToken: "") // OAuth2 Adapter
    }

    // MARK: OAuth Methods

    func loginUser(email: String, password: String, completion: @escaping (_ success: String?, _ error: NSError?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            //            var token: Token?
            //            self.manager.request(ClientRouter.loginUser(email: email, password: password))
            //            .validate(statusCode: 200..<300).responseString(completionHandler: { (response) in
            //                switch response.result {
            //                case .success(let json):
            //                    token = Mapper<Token>().map(JSONString: json)
            //                    if token != nil && token!.result != nil && token!.result!.token != nil {
            //                        String().saveToken(token: token!.result!.token!)
            //                    }
            //                default:
            //                    print("")
            //                }
            //                DispatchQueue.main.async {
            //                    completion(token, nil)
            //                }
            //            }).responseJSON { (response) in
            //                switch response.result {
            //                case .failure(let error):
            //                    DispatchQueue.main.async {
            //                        completion(nil, self.handleError(response: response, error: error as NSError))
            //                    }
            //                default:
            //                    print("")
            //                }
            //            }
        }
    }

    func logoutUser(completion: @escaping (_ success: Bool) -> ())  {
        DispatchQueue.main.async {
            ClientService.shared.currentUser = nil
            SDImageCache.shared().clearMemory()
            SDImageCache.shared().clearDisk()
            self.manager.adapter = ClientAccessTokenAdapter(accessToken: "")
            completion(true)
        }
    }

    // MARK: Client Methods - User

    func getUser(completion: @escaping (_ success: User?, _ error: NSError?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            var user: User?
            self.manager.request(ClientRouter.getUser())
                .validate(statusCode: 200..<300).responseString(completionHandler: { (response) in
                    switch response.result {
                    case .success(let json):
                        user = Mapper<User>().map(JSONString: json)
                    default:
                        print("")
                    }
                    DispatchQueue.main.async {
                        self.currentUser = user
                        completion(user, nil)
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

    // MARK: Error Handling Methods

    func handleError(response: DataResponse<Any>?, error: NSError) -> NSError? {
        if !app.internetConnected {
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
