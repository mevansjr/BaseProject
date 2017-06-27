//
//  LoginInteractor.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class LoginInteractor: LoginUseCase {
    weak var output: LoginInteractorOutput!

    func loginUser(_ username: String, password: String) {
        ClientService.shared.loginUser(username: username, password: password) { (user, error) in
            guard let err = error else {
                if user != nil {
                    self.output.loginUser(user!)
                }
                return
            }
            self.output.loginUserFailed(err)
        }
    }
}
