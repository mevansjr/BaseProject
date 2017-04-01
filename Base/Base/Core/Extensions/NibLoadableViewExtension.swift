//
//  NibLoadableViewExtension.swift
//  
//
//  Created by Mark Evans on 12/17/15.
//  Copyright © 2015 3Advance, LLC. All rights reserved..
//

import UIKit

extension NibLoadableView where Self: UIView {
    
    static var NibName: String {
        return String(describing: self)
    }
}
