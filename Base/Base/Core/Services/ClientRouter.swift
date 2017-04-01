//
//  ClientRouter.swift
//
//
//  Created by Mark Evans on 1/5/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Alamofire

enum ClientRouter: URLRequestConvertible {
    case loginUser(email: String, password: String)
    case getUser()
    
    static let baseURLString = Global.API_BASE_DOMAIN
    
    var method: HTTPMethod {
        switch self {
        case .loginUser:
            return .post
        case .getUser:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .loginUser:
            return "/login"
        case .getUser:
            return "/users/me"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try ClientRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .loginUser(let email, let password):
            let parameters = ["email": email, "password": password]
            UserDefaults.standard.set(email, forKey: Global.LOGIN_EMAIL_KEY)
            UserDefaults.standard.set(password, forKey: Global.LOGIN_PASSWORD_KEY)
            UserDefaults.standard.synchronize()
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .getUser:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        String().getServicePath(urlRequest: urlRequest)
        return urlRequest
    }
}
