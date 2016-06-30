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
	
	let form = Form(name: "Form")
	

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		tableView.registerNib(SelectInputTableViewCell.Nib, forCellReuseIdentifier: SelectInputTableViewCell.Identifier)
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
			.addInput(DateInput(name: "")
				.setHint("Date")
				.setDateFormat("dd--MM---yyyy")
			)
			.addInput(NumberInput(name: "")
				.setHint("Number")
			)
			.addInput(SelectInput(name: "")
				.setHint("Some hint")
				.addOption(SelectInput.Option(description: "1", value: ""))
				.addOption(SelectInput.Option(description: "2", value: ""))
				.addOption(SelectInput.Option(description: "3", value: ""))
				.addOption(SelectInput.Option(description: "4", value: ""))
				.addOption(SelectInput.Option(description: "5", value: ""))
				.addOption(SelectInput.Option(description: "6", value: ""))
				.addOption(SelectInput.Option(description: "8", value: ""))
				.addOption(SelectInput.Option(description: "7", value: ""))
				.addOption(SelectInput.Option(description: "9", value: ""))
			)
		)
		.on(submit: { form in
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
		let input = form.sectionAtIndex(indexPath.section).inputAtIndex(indexPath.row)
		
		if let input = input as? TextInput {
			
			let cell = tableView.dequeueReusableCellWithIdentifier(TextInputTableViewCell.Identifier) as! TextInputTableViewCell
			cell.input = input
			
			return cell
			
		}
		
		if let input = input as? SelectInput {
			let cell = tableView.dequeueReusableCellWithIdentifier(SelectInputTableViewCell.Identifier) as! SelectInputTableViewCell
			cell.input = input
			return cell
		}
		return UITableViewCell()
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.1
	}
}

