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
			if let input = input {
				
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
		
	}
}
