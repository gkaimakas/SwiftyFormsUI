//
//  FormTableView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 14/06/16.
//
//

import Foundation
import UIKit

open class FormTableView: UITableView {
	fileprivate enum KeyboardState: Int {
		case visible = 0
		case notVisible = 1
	}

	fileprivate var originalBottonContentInset: CGFloat = 0
	fileprivate var keyboardState: KeyboardState = .notVisible

	public override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		handleKeyboard()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		handleKeyboard()
	}

	open func handleKeyboard() {

		NotificationCenter.default
			.addObserver(self, selector: #selector(FormTableView.handleKeyboardShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

		NotificationCenter.default
			.addObserver(self, selector: #selector(FormTableView.handleKeyboardHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

	}

	@objc func handleKeyboardShow(_ notification: Notification){
		self.layoutIfNeeded()

		if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {

			if keyboardState == .notVisible {
				originalBottonContentInset = self.contentInset.bottom
			}

			self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: 0 + keyboardSize.height, right: self.contentInset.right)
		}

		UIView.animate(withDuration: 0.5, animations: { () -> Void in
			self.layoutIfNeeded()
			self.keyboardState = .visible
		})
	}

	@objc func handleKeyboardHide(_ notification: Notification){
		self.layoutIfNeeded()
		self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: self.originalBottonContentInset, right: self.contentInset.right)

		UIView.animate(withDuration: 0.5, animations: { () -> Void in
			self.layoutIfNeeded()
			self.keyboardState = .notVisible
		})
	}
}
