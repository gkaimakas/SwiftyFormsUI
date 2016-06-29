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

public class DateInputTableViewCell: UITableViewCell {
	public static let Identifier = String(DateInputTableViewCell)
	public static let Nib = UINib(nibName: String(DateInputTableViewCell), bundle: NSBundle(forClass: DateInputTableViewCell.self))
	
	@IBOutlet public var hintLabel: UILabel!
	@IBOutlet public var datePickerView: UIDatePicker!
	
}