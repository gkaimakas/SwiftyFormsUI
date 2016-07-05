//
//  SelectInputPicker.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 04/07/16.
//
//

import Foundation
import SwiftyForms
import UIKit

public class SelectInputPickerView: UIPickerView {
	public var input: SelectInput? = nil {
		didSet {
			guard let input = self.input else {
				return
			}
			
			self.dataSource = self
			self.delegate = self
			
			input.on(add: { _ in
					self.reloadAllComponents()
				})
				.on(remove: { _ in
					self.reloadAllComponents()
				})
			
			
			selectRow(input.selectedOptionIndex, inComponent: 0, animated: true)
		}
	}
}

extension SelectInputPickerView: UIPickerViewDataSource {
	public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		guard let input = input else {
			return 0
		}
		
		return input.numberOfOptions
	}
}

extension SelectInputPickerView: UIPickerViewDelegate {
	public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return input?.optionAtIndex(row).description
	}
	
	public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		input?.selectOptionAtIndex(row)
	}
}
