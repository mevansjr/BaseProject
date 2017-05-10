//
//  HomePresenter.swift
//  Base
//
//  Created by Mark Evans on 3/31/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation


class HomePresenter: HomePresentation {

    // MARK: Properties

    weak var view: HomeView?
    var interactor: HomeUseCase!
    var router: HomeWireframe!

    func viewDidAppear(_ animated: Bool) {
        didGetUser()
    }

    func viewDidLoad() {
    }

    func didGetUser() {
        interactor.getUser()
    }
}

extension HomePresenter: HomeInteractorOutput {
    func getUserFailed() {
        view?.hideActivityIndicator()
    }

    func getUser(_ user: User) {
        view?.hideActivityIndicator()
    }
}
