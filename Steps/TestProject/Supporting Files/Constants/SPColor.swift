//
//  SPColor.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import UIKit

struct SPColor {
    
    struct colors {
        static let lightBlue = UIColor.RGBA(161, 215, 255, 1)
    }
    
    struct base {
        static let mainTint = SPColor.colors.lightBlue
        static let mainTitle = SPColor.colors.lightBlue
    }
    
    struct navigationBar {
        static let tint = SPColor.base.mainTint
        static let title = SPColor.base.mainTint
        static let barButtonText = SPColor.base.mainTint
        static let barButtonTint = SPColor.base.mainTint
    }
}
