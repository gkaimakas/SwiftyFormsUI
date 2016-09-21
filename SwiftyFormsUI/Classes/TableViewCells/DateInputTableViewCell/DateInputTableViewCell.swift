//
//  DateInputTableViewCell.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 29/06/16.
//
//

import Foundation
import SnapKit
import SwiftyForms
import UIKit

open class DateInputTableViewCell: UITableViewCell {
	open static let Identifier = String(describing: DateInputTableViewCell.self)
	open static let Nib = UINib(nibName: String(describing: DateInputTableViewCell.self), bundle: Bundle(for: DateInputTableViewCell.self))
	
	@IBOutlet open var hintLabel: UILabel!
	@IBOutlet open var datePickerView: UIDatePicker!
	
}
