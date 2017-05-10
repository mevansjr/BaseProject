//
//  LoginContract.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved..
//

import UIKit

protocol LoginView: IndicatableView {
    var presenter: LoginPresentation! { get set }
    func showNoContentScreen()
}

protocol LoginPresentation: class {
    weak var view: LoginView? { get set }
    var interactor: LoginUseCase! { get set }
    var router: LoginWireframe! { get set }
    func viewDidLoad()
    func didClickLogin()
}

protocol LoginUseCase: class {
    weak var output: LoginInteractorOutput! { get set }
    func loginUser()
}

protocol LoginInteractorOutput: class {
    func loginUser(_ user: User)
    func loginUserFailed()
}

protocol LoginWireframe: class {
    weak var viewController: UIViewController? { get set }
    static func assembleModule() -> UIViewController
}
