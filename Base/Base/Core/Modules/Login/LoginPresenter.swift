//
//  LoginPresenter.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresentation {
    weak var view: LoginView?
    var interactor: LoginUseCase!
    var router: LoginWireframe!
    
    func viewDidLoad() {
    }
    
    func didClickLogin() {
        interactor.loginUser()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginUserFailed() {
        view?.showNoContentScreen()
        view?.hideActivityIndicator()
    }

    func loginUser(_ user: User) {
        view?.hideActivityIndicator()
    }
}
