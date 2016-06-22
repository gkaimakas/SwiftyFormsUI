//
//  UITableView.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 22/06/16.
//
//

import Foundation
import UIKit

extension UITableViewCell {
	var tableView: UITableView? {
		var view = self.superview
		
		while view != nil && !(view?.isKindOfClass(UITableView))! {
			view = view?.superview
		}
		
		if let view = view as? UITableView {
			return view
		}
		
		return nil
	}
}
