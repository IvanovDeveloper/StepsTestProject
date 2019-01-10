//
//  UITableView+extension.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol IdentifiedTableViewCell {
    static var identifier: String { get }
}

infix operator -->

extension UITableView {
    
    static func --> <T: UITableViewCell & IdentifiedTableViewCell>(_ tableView: UITableView, _ type: T.Type) -> T {
        if let cell = tableView.dequeueReusableCell(withIdentifier: type.identifier) as? T {
            return cell
        } else {
            tableView.register(UINib.init(nibName: String.init(describing: type.self), bundle: nil), forCellReuseIdentifier: type.identifier)
            return tableView.dequeueReusableCell(withIdentifier: type.identifier) as! T
        }
    }
}
