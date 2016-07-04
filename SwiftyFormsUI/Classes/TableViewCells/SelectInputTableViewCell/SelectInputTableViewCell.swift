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

public class SelectInputTableViewCell: UITableViewCell {
	public static let Identifier = String(SelectInputTableViewCell)
	public static let Nib = UINib(nibName: String(SelectInputTableViewCell), bundle: NSBundle(forClass: SelectInputTableViewCell.self))
	
	@IBOutlet public var hintLabel: UILabel!
	@IBOutlet public var pickerView: SelectInputPickerView!
	
	private var errorLabel: UILabel? = nil
	
	public var input: SelectInput? = nil {
		didSet {
			hintLabel.text = input?.hint
			pickerView.input = input
			
			input?.on(hint: { result in
					self.hintLabel.text = result
				})
				.on(value: { input in
					self.handleValidation()
				})
			
			guard let input = input else {
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
	
	func addErrorLabelWithError(error: String?) {
		guard let error = error else {
			return
		}
		
		errorLabel = UILabel()
		errorLabel?.font = UIFont.systemFontOfSize(12, weight: UIFontWeightThin)
		
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
