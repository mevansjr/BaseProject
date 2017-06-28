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
        view?.showActivityIndicator()
        interactor.loginUser("mevansjr@gmail.com", password: "Therock5")
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func loginUserFailed(_ error: Error) {
        view?.hideActivityIndicator()
        view?.displayLoginUserError(error)
    }

    func loginUser(_ user: User) {
        view?.hideActivityIndicator()
        view?.displayLoginUser(user)
    }
}
