//
//  UIView+extension.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Initialization -

extension UIView {
    
    class func instanceFromNib<GenericType: UIView>() -> GenericType? {
        return UINib(nibName: String.init(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? GenericType
    }
    
    class func create<GenericType: UIView>() -> GenericType {
        return GenericType.instanceFromNib() as! GenericType
    }
}
