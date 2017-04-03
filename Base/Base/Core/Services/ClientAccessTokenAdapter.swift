//
//  ClientAccessTokenAdapter.swift
// 
//
//  Created by Mark Evans on 1/9/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation
import Alamofire

class ClientAccessTokenAdapter: RequestAdapter {
    private let accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if urlRequest.url != nil && urlRequest.url!.absoluteString.hasPrefix(SecureStrings.shared.ApiHost) {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "token")
        }
        return urlRequest
    }
}
