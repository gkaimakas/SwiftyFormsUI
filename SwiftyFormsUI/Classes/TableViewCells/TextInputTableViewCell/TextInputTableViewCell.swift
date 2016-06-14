//
//  TextInputTableViewCell.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 14/06/16.
//
//

import Foundation
import SwiftyForms
import UIKit

public class TextInputTableViewCell: UITableViewCell {
	public static let Identifier = String(TextInputTableViewCell)
	public static let Nib = UINib(nibName: String(TextInputTableViewCell), bundle: NSBundle(forClass: TextInputTableViewCell.self))
	
	
	@IBOutlet public var hintLabel: UILabel!
	@IBOutlet public var textInputField: TextInputField!
	
	public var input: TextInput? = nil {
		didSet {
			
		}
	}
}