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

    func loginUser() {
        print("LOGIN USER")
        showInController()
    }
}
