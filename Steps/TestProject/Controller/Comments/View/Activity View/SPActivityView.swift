//
//  VMHireActivityView.swift
//  vciom
//
//  Created by Ivanov Developer on 7/9/18.
//  Copyright © 2018 Andrii Ivanov. All rights reserved.
//

import UIKit

class SPActivityView: UIView {

    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let heightConstraint = NSLayoutConstraint(item: self,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 44)
        addConstraint(heightConstraint)
    }
}
