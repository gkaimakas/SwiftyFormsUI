//
//  TextInputTableViewCell.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 14/06/16.
//
//

import Foundation
import SnapKit
import SwiftyForms
import UIKit

open class TextInputTableViewCell: UITableViewCell {
	open static let Identifier = String(describing: TextInputTableViewCell.self)
	open static let Nib = UINib(nibName: String(describing: TextInputTableViewCell.self), bundle: Bundle(for: TextInputTableViewCell.self))
	
	
	@IBOutlet open var hintLabel: UILabel!
	@IBOutlet open var textInputField: TextInputField!
	
	fileprivate var errorLabel: UILabel? = nil
	
	open var input: TextInput? = nil {
		didSet {
			hintLabel.text = input?.hint
			textInputField.input = input
			
			input?.on(hint: { result in
					self.hintLabel.text = result
				})
				.on(value: { input in
					self.handleValidation()
				})
		}
	}
	
	
	
	func handleValidation() {
		guard let input = textInputField.input else {
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
			make.left.right.equalTo(textInputField)
			make.top.equalTo(textInputField.snp_bottom).inset(-4)
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
