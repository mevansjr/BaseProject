//
//  HomeContract.swift
//  Base
//
//  Created by Mark Evans on 3/31/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation


protocol HomeView: IndicatableView {
}

protocol HomePresentation: class {
    weak var view: HomeView? { get set }
    var interactor: HomeUseCase! { get set }
    var router: HomeWireframe! { get set }

    func viewDidLoad()
}

protocol HomeUseCase: class {
    weak var output: HomeInteractorOutput! { get set }
}

protocol HomeInteractorOutput: class {
    func getUser(_ user: User)
    func getUserFailed()
}

protocol HomeWireframe: class {
    weak var viewController: UIViewController? { get set }

    func assembleModule() -> UIViewController
}
