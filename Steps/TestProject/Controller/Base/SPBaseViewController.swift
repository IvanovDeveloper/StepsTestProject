//
//  SPBaseViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

class SPBaseViewController: UIViewController {

    // MARK: Properties
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        container.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        container.backgroundColor = UIColor(red: 18/255, green: 6/255, blue: 0/255, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.style = UIActivityIndicatorView.Style.white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
    }
    
    // MARK: Helper
    
    /// Loader - Start Activity Indicator
    func showActivityIndicator(doShowBackgroundColor: Bool = true) {
        view.addSubview(container)
        view.bringSubviewToFront(container)
        activityIndicator.startAnimating()
    }
    
    /// Loader - Stop Activity Indicator
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    // MARK: Error displaying
    
    func showError(_ error: Error) {
        print(error)
        
        let alertController = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        present(alertController, animated: true, completion: nil)
    }
}
