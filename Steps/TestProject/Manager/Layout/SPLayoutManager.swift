//
//  SPLayoutManager.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import UIKit

/// Indication of all storyboards which used in the app.
enum SPStoryboard {
    case main
    
    var value: UIStoryboard {
        var name = ""
        switch self {
        case .main: name = "Main"
        }
        return UIStoryboard(name: name, bundle: nil)
    }
}

class SPLayoutManager {
    
    static func create<GenericType: UIViewController>(controller: GenericType.Type, from storyboard: SPStoryboard) -> GenericType {
        let viewController = storyboard.value.instantiateViewController(withIdentifier: String.init(describing: controller)) as! GenericType
        return viewController
    }
}
