//
//  SPComentsSettingsViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit
import MBProgressHUD
import Moya

class SPCommentsSettingsViewController: SPBaseViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var lowerBoundTextField: UITextField! {
        didSet {
            lowerBoundTextField.delegate = self
        }
    }
    @IBOutlet weak var upperBoundTextField: UITextField! {
        didSet {
            upperBoundTextField.delegate = self
        }
    }
    @IBOutlet weak var buttonSectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var continueButton: UIButton!
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
    }

    // MARK: Configurations
    
    /// Configuration of controller's UI elements.
    fileprivate func defaultConfigurations() {
        
        navigationItem.title = "Settings"
        
        // Continue Button
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = buttonSectionViewHeight.constant/2
        
        // Bound TextFields
        lowerBoundTextField.text = "1"
        upperBoundTextField.text = "100"
    }
    
    // MARK: Actions
    
    @IBAction func onContinueButton(_ sender: Any) {
        showCommentsScreen()
    }
    
    // MARK: Navigation
    
    var commentsViewController: SPCommentsViewController?
    var hud: MBProgressHUD?
    
    fileprivate func showCommentsScreen() {
        let lowerId = Int(lowerBoundTextField.text ?? "")
        let upperId = Int(upperBoundTextField.text ?? "")
        let viewController: SPCommentsViewController = SPCommentsViewController.createWith(lowerId: lowerId, upperId: upperId)
        commentsViewController = viewController
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Comments loading"
        hud.detailsLabel.text = "Cancel"
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelHud))
        hud.addGestureRecognizer(tap)
        self.hud = hud
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let `self` = self else {return}
            self.commentsViewController?.loadComments(successHandler: { [weak self] in
                guard let `self` = self else {return}
                self.commentsViewController = nil
                self.hud?.hide(animated: true)
                self.hud = nil
                self.navigationController?.show(viewController, sender: nil)
                
            }) { [weak self] (error) in
                guard let `self` = self else {return}
                self.commentsViewController = nil
                self.hud?.hide(animated: true)
                self.hud = nil
                self.showError(error)
            }
        }  
    }
    
    // MARK: Actions
    
    @objc func cancelHud() {
        self.commentsViewController?.requestTask?.cancel()
        self.commentsViewController = nil
        self.hud?.hide(animated: true)
        self.hud = nil
    }
}

// MARK: - UITextFieldDelegate -

extension SPCommentsSettingsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else { return false }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        if updatedText.isEmpty {
            return true
        } else {
            // Should be only whole numbers
            guard Int(updatedText) != nil else { return false }
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case lowerBoundTextField:
            guard let number = Int(textField.text ?? ""), number > 0 else {
                textField.text = "1"
                break
            }
            textField.text = "\(number)"
            
            guard let upperNumber = Int(upperBoundTextField.text ?? "") else {
                break
            }
            guard number >= upperNumber else {
                break
            }
            upperBoundTextField.text = "\(number + 1)"
            
        case upperBoundTextField:
            guard let number = Int(textField.text ?? "" ), number > 1 else {
                textField.text = "2"
                lowerBoundTextField.text = "1"
                break
            }
            textField.text = "\(number)"
            
            guard let lowerNumber = Int(lowerBoundTextField.text ?? "") else {
                break
            }
            guard number <= lowerNumber else {
                break
            }
            lowerBoundTextField.text = "\(number - 1)"
        default: break
        }
    }

}
