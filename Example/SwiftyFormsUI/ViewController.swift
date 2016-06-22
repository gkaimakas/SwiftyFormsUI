//
//  ViewController.swift
//  SwiftyFormsUI
//
//  Created by gkaimakas on 06/02/2016.
//  Copyright (c) 2016 gkaimakas. All rights reserved.
//

import UIKit
import SwiftValidators
import SwiftyForms
import SwiftyFormsUI

class ViewController: UIViewController {
	@IBOutlet weak var tableView: FormTableView!
	
	var input: TextInput? = nil
	
	let form = Form<FormDataObject>(name: "Form")
	

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		tableView.registerNib(TextInputTableViewCell.Nib, forCellReuseIdentifier: TextInputTableViewCell.Identifier)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 40.0
		tableView.dataSource = self
		tableView.delegate = self
		
		form.addSection(Section(name: "Main")
			.addInput(TextInput(name: FormDataObject.FieldName)
				.setHint(FormDataObject.FieldName)
				.addValidationRule(Validator.required, message: "err_validation_required")
				.addValidationRule(Validator.minLength(5), message: "err_validation_min_length")
			)
			.addInput(TextInput(name: FormDataObject.FieldNumber)
				.setHint(FormDataObject.FieldNumber)
				.addValidationRule(Validator.required, message: "err_validation_required")
				.addValidationRule(Validator.minLength(5), message: "err_validation_min_length")
			)
		)
		.on(submit: { form in
			let dataObject = form.dataObject
			print(dataObject)
		})
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	@IBAction func handleSubmit(sender: AnyObject) {
		form.submit()
	}
}

extension ViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return form.numberOfSections
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return form.sectionAtIndex(section).numberOfInputs
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let input = form.sectionAtIndex(indexPath.section).inputAtIndex(indexPath.row) as! TextInput
		
		let cell = tableView.dequeueReusableCellWithIdentifier(TextInputTableViewCell.Identifier) as! TextInputTableViewCell
		cell.input = input
		
		return cell
	}
}

extension ViewController: UITableViewDelegate {
	
}

