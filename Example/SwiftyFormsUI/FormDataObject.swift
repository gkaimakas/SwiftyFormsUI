//
//  FormDataObject.swift
//  SwiftyFormsUI
//
//  Created by Γιώργος Καϊμακάς on 22/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyForms

struct FormDataObject: FormDataSerializable {
	static let FieldName = "name"
	static let FieldNumber = "number"

	let name: String
	let number: String
	
	init(name: String, number: String) {
		self.name = name
		self.number = number
	}
	
	init?(data: [String : Any]?) {
		guard let data = data else {
			return nil
		}
		
		guard let name = data[FormDataObject.FieldName] as? String,
			let number = data[FormDataObject.FieldNumber] as? String else {
				return nil
		}
		
		self.init(name: name, number: number)
	}
}
