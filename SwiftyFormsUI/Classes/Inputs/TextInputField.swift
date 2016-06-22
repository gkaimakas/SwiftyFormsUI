//
//  TextInput.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 02/06/16.
//
//

import Foundation
import SwiftyForms
import UIKit

public class TextInputField: UITextField {
	public var input: TextInput? = nil {
		didSet {
			
			self.delegate = self
			
			if let passwordInput = self.input as? PasswordInput {
				secureTextEntry = true
				keyboardType = .Default
				inputView = nil
				
				return
			}
			
			if let emailInput = self.input as? EmailInput {
				secureTextEntry = false
				keyboardType = .EmailAddress
				inputView = nil
				
				return
			}
			
			if let PhoneInput = self.input as? PhoneInput {
				secureTextEntry = false
				keyboardType = UIKeyboardType.PhonePad
				inputView = nil
			}
		}
	}
}

extension TextInputField: UITextFieldDelegate {
	public func textFieldDidEndEditing(textField: UITextField) {
		guard let input = input else {
			return
		}
		
		guard let text = textField.text else {
			return
		}
		
		input.value = text
	}
	
	public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		
		if let input = input {
			let newValue = (text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
			input.value = newValue
		}
		
		return true
		
	}
}
