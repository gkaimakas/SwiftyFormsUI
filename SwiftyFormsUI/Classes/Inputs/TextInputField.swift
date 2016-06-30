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
			text = input?.value
			
			
			if let _ = self.input as? PasswordInput {
				secureTextEntry = true
				keyboardType = .Default
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? EmailInput {
				secureTextEntry = false
				keyboardType = .EmailAddress
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? PhoneInput {
				secureTextEntry = false
				keyboardType = UIKeyboardType.PhonePad
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? NumberInput {
				secureTextEntry = false
				keyboardType = UIKeyboardType.NumbersAndPunctuation
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? DateInput {
				self.delegate = nil
				let datePicker = UIDatePicker()
				datePicker.datePickerMode = UIDatePickerMode.Date
				datePicker.addTarget(self, action: #selector(TextInputField.handleDateSelection(_:)), forControlEvents: .ValueChanged)
				inputView = datePicker
				
				return
			}
			
			if let _ = self.input as? TimeInput {
				self.delegate = nil
				let datePicker = UIDatePicker()
				datePicker.datePickerMode = UIDatePickerMode.Time
				datePicker.addTarget(self, action: #selector(TextInputField.handleTimeSelection(_:)), forControlEvents: .ValueChanged)
				inputView = datePicker
				
				return
			}
			
			if let input = self.input as? SelectInput {
				self.delegate = nil
				let picker = UIPickerView()
				picker.dataSource = self
				picker.delegate = self
				inputView = picker
				text = input.optionAtIndex(input.selectedOptionIndex).description
				
				return
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

extension TextInputField: UIPickerViewDataSource {
	public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		guard let input = input as? SelectInput else {
			return 0
		}
		
		return input.numberOfOptions
	}
}

extension TextInputField: UIPickerViewDelegate {
	public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		guard let input = input as? SelectInput else {
			return nil
		}
		
		return input.optionAtIndex(row).description
	}
	
	public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let input = input as? SelectInput else {
			return
		}
		
		input.selectOptionAtIndex(row)
		self.text = input.optionAtIndex(input.selectedOptionIndex).description
	}
}

extension TextInputField {
	@objc func handleDateSelection(sender: UIDatePicker) {
		guard let input = input as? DateInput else {
			return
		}
		
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = input.dateFormat
		let date = dateFormatter.stringFromDate(sender.date)
		text = date
		input.value = date
	}
	
	@objc func handleTimeSelection(sender: UIDatePicker) {
		guard let input = input as? TimeInput else {
			return
		}
		
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = input.timeFormat
		let time = dateFormatter.stringFromDate(sender.date)
		text = time
		input.value = time
	}
}



