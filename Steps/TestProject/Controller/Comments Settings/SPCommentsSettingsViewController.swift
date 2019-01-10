//
//  SPComentsSettingsViewController.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

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
        
        lowerBoundTextField.text = "1"
        upperBoundTextField.text = "2"
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
