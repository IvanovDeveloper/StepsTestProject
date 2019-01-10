//
//  SPCommentsViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

class SPCommentsViewController: SPBaseViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
    }
    
    // MARK: Configurations
    
    /// Configuration of controller's UI elements.
    fileprivate func defaultConfigurations() {
        
        navigationItem.title = "Comments"
        
    }

}
