//
//  SPBaseNavigationViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

class SPBaseNavigationViewController: UINavigationController {

    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultConfigurations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Configurations
    
    /// Configuration of controller's UI elements.
    fileprivate func defaultConfigurations() {
        navigationBar.tintColor = SPColor.navigationBar.tint
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
                                             NSAttributedString.Key.foregroundColor: SPColor.navigationBar.title]
    }
}
