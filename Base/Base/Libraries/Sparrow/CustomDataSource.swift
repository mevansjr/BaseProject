//
//  CustomDialogInteractiveDataSourceInterface.swift
//  Base
//
//  Created by Mark Evans on 6/22/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import UIKit

class CustomDataSource: SPRequestPermissionDialogInteractiveDataSource {

    override func headerBackgroundView() -> UIView {
        let headerBackground = UIView()
        headerBackground.backgroundColor = UIColor.green
        return headerBackground
    }

    override func mainColor() -> UIColor {
        return UIColor.red
    }

    override func secondColor() -> UIColor {
        return UIColor.green
    }

    override func headerTitle() -> String {
        return ""
    }

    override func headerSubtitle() -> String {
        return ""
    }

    override func topAdviceTitle() -> String {
        return ""
    }

    override func bottomAdviceTitle() -> String {
        return ""
    }

    override func underDialogAdviceTitle() -> String {
        return ""
    }
}
