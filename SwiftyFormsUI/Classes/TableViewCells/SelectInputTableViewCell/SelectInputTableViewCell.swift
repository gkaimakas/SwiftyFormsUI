//
//  SelectInputTableViewCell.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 29/06/16.
//
//

import Foundation
import SnapKit
import SwiftyForms
import UIKit

open class SelectInputTableViewCell: UITableViewCell {
	open static let Identifier = String(describing: SelectInputTableViewCell.self)
	open static let Nib = UINib(nibName: String(describing: SelectInputTableViewCell.self), bundle: Bundle(for: SelectInputTableViewCell.self))
	
	@IBOutlet open var hintLabel: UILabel!
	@IBOutlet open var pickerView: SelectInputPickerView!
	
	fileprivate var errorLabel: UILabel? = nil
	
	open var input: SelectInput? = nil {
		didSet {
			hintLabel.text = input?.hint
			pickerView.input = input
			
			input?.on(hint: { result in
					self.hintLabel.text = result
				})
				.on(value: { input in
					self.handleValidation()
				})
			
			guard let _ = input else {
				return
			}
			
		}
	}
	func handleValidation() {
		guard let input = input else {
			return
		}
		
		if input.isValid == true {
			removeErrorLabel()
		}
		
		if input.isValid == false {
			if let errorLabel = errorLabel {
				errorLabel.text = input.errors.first
				self.tableView?.beginUpdates()
				self.tableView?.endUpdates()
			} else {
				addErrorLabelWithError(input.errors.first)
			}
		}
	}
	
	func addErrorLabelWithError(_ error: String?) {
		guard let error = error else {
			return
		}
		
		errorLabel = UILabel()
		errorLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
		
		errorLabel?.text = error
		errorLabel?.numberOfLines = 0
		errorLabel?.sizeToFit()
		
		contentView.addSubview(errorLabel!)
		
		errorLabel?.snp_makeConstraints() { make in
			make.left.right.equalTo(hintLabel)
			make.top.equalTo(pickerView.snp_bottom).inset(-4)
			make.bottom.equalTo(contentView.snp_bottom).inset(4)
		}
		
		
		errorLabel?.sizeToFit()
		self.tableView?.beginUpdates()
		updateConstraints()
		self.tableView?.endUpdates()
	}
	
	func removeErrorLabel() {
		guard let _ = errorLabel else {
			return
		}
		
		self.errorLabel?.removeFromSuperview()
		self.errorLabel = nil
		
		
		self.tableView?.beginUpdates()
		updateConstraints()
		self.tableView?.endUpdates()
	}
}
