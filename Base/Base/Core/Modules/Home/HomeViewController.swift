//
//  HomeViewController.swift
//  Base
//
//  Created by Mark Evans on 3/31/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

class HomeViewController: UIViewController {

    var presenter: HomePresentation!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            permissionsCheck(vc: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    fileprivate func setupView() {
        navigationItem.title = "Home"
    }
}

extension HomeViewController: HomeView {
    
}
