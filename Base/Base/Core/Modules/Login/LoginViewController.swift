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
        navigationItem.title = "Login"
    }
}

extension LoginViewController: LoginView {
    func showNoContentScreen() {
    }
}
