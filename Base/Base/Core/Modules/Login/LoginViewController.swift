//
//  LoginViewController.swift
//
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
  
    fileprivate func setupView() {
        navigationItem.title = self.titleFromPlist()
    }

    @IBAction func loginAction() {
        presenter.didClickLogin()
    }
}

extension LoginViewController: LoginView {
    func displayLoginUser(_ user: User) {
        ClientService.shared.currentUser = user
        Constants.shared.showInController()
    }

    func displayLoginUserError(_ error: Error) {
        print("error: \(error.localizedDescription)")
    }

    func showActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func hideActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
