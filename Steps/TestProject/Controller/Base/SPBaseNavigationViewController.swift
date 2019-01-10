//
//  SPBaseNavigationViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

class SPBaseNavigationViewController: UINavigationController {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.navigationBar.tintColor = SPColor.navigationBar.tint
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium),
                                                            NSAttributedString.Key.foregroundColor: SPColor.navigationBar.title]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : SPColor.navigationBar.barButtonText], for: .normal)
        UIBarButtonItem.appearance().tintColor = SPColor.navigationBar.barButtonTint
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
