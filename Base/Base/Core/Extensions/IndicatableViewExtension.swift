//
//  IndicatableViewExtension.swift
//  
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved.
//

import Foundation
import PKHUD

extension IndicatableView where Self: UIViewController {
    
    func showActivityIndicator() {
        HUD.show(.progress)
    }
    
    func hideActivityIndicator() {
        HUD.hide()
    }
}
