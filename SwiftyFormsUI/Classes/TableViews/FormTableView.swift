//
//  FormTableView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 14/06/16.
//
//

import Foundation
import UIKit

public class FormTableView: UITableView {
	private var originalBottonContentInset: CGFloat = 0
	public override init(frame: CGRect, style: UITableViewStyle) {
		super.init(frame: frame, style: style)
		handleKeyboard()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		handleKeyboard()
	}
	
	public func handleKeyboard() {
		
		NSNotificationCenter.defaultCenter()
			.addObserver(self, selector: #selector(FormTableView.handleKeyboardShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
		
		NSNotificationCenter.defaultCenter()
			.addObserver(self, selector: #selector(FormTableView.handleKeyboardHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
		
	}
	
	@objc func handleKeyboardShow(notification: NSNotification){
		self.layoutIfNeeded()
		let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size
		
		if let keyboardSize = keyboardSize {
			originalBottonContentInset = self.contentInset.bottom
			self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: 0 + keyboardSize.height, right: self.contentInset.right)
		}
		
		UIView.animateWithDuration(0.5) { () -> Void in
			self.layoutIfNeeded()
		}
	}
	
	@objc func handleKeyboardHide(notification: NSNotification){
		self.layoutIfNeeded()
		self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: self.originalBottonContentInset, right: self.contentInset.right)
		
		UIView.animateWithDuration(0.5) { () -> Void in
			self.layoutIfNeeded()
		}
	}
}