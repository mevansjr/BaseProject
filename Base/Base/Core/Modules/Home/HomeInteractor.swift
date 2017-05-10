//
//  HomeInteractor.swift
//  Base
//
//  Created by Mark Evans on 3/31/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import Foundation

class HomeInteractor: HomeUseCase  {

    weak var output: HomeInteractorOutput!

    func getUser() {
        print("GET USER")
    }
}
