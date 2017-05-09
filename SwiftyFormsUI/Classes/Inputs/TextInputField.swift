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

open class TextInputField: UITextField {
	open var input: TextInput? = nil {
		didSet {
			
			self.delegate = self
			text = input?.value
			inputView = nil
			
			
			if let _ = self.input as? PasswordInput {
				isSecureTextEntry = true
				keyboardType = .default
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? EmailInput {
				isSecureTextEntry = false
				keyboardType = .emailAddress
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? PhoneInput {
				isSecureTextEntry = false
				keyboardType = UIKeyboardType.phonePad
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? NumberInput {
				isSecureTextEntry = false
				keyboardType = UIKeyboardType.numbersAndPunctuation
				inputView = nil
				
				return
			}
			
			if let _ = self.input as? DateInput {
				self.delegate = nil
				let datePicker = UIDatePicker()
				datePicker.datePickerMode = UIDatePickerMode.date
				datePicker.addTarget(self, action: #selector(TextInputField.handleDateSelection(_:)), for: .valueChanged)
				inputView = datePicker
				
				return
			}
			
			if let _ = self.input as? TimeInput {
				self.delegate = nil
				let datePicker = UIDatePicker()
				datePicker.datePickerMode = UIDatePickerMode.time
				datePicker.addTarget(self, action: #selector(TextInputField.handleTimeSelection(_:)), for: .valueChanged)
				inputView = datePicker
				
				return
			}
			
			if let input = self.input as? SelectInput {
				self.delegate = self
				let picker = UIPickerView()
				picker.dataSource = self
				picker.delegate = self
				inputView = picker
				
				if let selectedOptionIndex = input.selectedOptionIndex {
					text = input.optionAtIndex(selectedOptionIndex).description
				}
				
				let _ = input.on(add: { _ in
						picker.reloadAllComponents()
					})
					.on(remove: { _ in
						picker.reloadAllComponents()
					})
				
				return
			}
		}
	}
}

extension TextInputField: UITextFieldDelegate {
	public func textFieldDidEndEditing(_ textField: UITextField) {
        if let _ = input as? SelectInput {
            return
        }
        
		guard let input = input else {
			return
		}
		
		guard let text = textField.text else {
			return
		}
		
		input.value = text
	}
	
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = input as? SelectInput {
            return true
        }
		
		if let input = input {
			let newValue = (text! as NSString).replacingCharacters(in: range, with: string)
			input.value = newValue
		}
		
		return true
		
	}
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let input = self.input as? SelectInput,
            let pickerView = self.inputView as? UIPickerView {
            
            if let selectedIndex = input.selectedOptionIndex {
                pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
            } else {
                input.selectOptionAtIndex(0)
                pickerView.selectRow(0, inComponent: 0, animated: true)
            }
        }
        
        return true
    }
}

extension TextInputField: UIPickerViewDataSource {
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		guard let input = input as? SelectInput else {
			return 0
		}
		
		return input.numberOfOptions
	}
}

extension TextInputField: UIPickerViewDelegate {
	public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		guard let input = input as? SelectInput else {
			return nil
		}
		
		return input.optionAtIndex(row).description
	}
	
	public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		guard let input = input as? SelectInput else {
			return
		}
		
		let _ = input.selectOptionAtIndex(row)
		self.text = input.optionAtIndex(row).description
	}
}

extension TextInputField {
	@objc func handleDateSelection(_ sender: UIDatePicker) {
		guard let input = input as? DateInput else {
			return
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = input.dateFormat
		let date = dateFormatter.string(from: sender.date)
		text = date
		input.value = date
	}
	
	@objc func handleTimeSelection(_ sender: UIDatePicker) {
		guard let input = input as? TimeInput else {
			return
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = input.timeFormat
		let time = dateFormatter.string(from: sender.date)
		text = time
		input.value = time
	}
}



