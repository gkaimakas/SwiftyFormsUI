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
		
		tableView.register(SelectInputTableViewCell.Nib, forCellReuseIdentifier: SelectInputTableViewCell.Identifier)
		tableView.register(TextInputTableViewCell.Nib, forCellReuseIdentifier: TextInputTableViewCell.Identifier)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 40.0
		tableView.dataSource = self
		tableView.delegate = self
		
		let _ = form.addSection(Section(name: "Main")
			.addInput(TextInput(name: FormDataObject.FieldName)
				.setHint(FormDataObject.FieldName)
				.addValidationRule(Validators.required(), message: "err_validation_required")
				.addValidationRule(Validators.minLength(5), message: "err_validation_min_length")
			)
			.addInput(TextInput(name: FormDataObject.FieldNumber)
				.setHint(FormDataObject.FieldNumber)
				.addValidationRule(Validators.required(), message: "err_validation_required")
				.addValidationRule(Validators.minLength(5), message: "err_validation_min_length")
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
	@IBAction func handleSubmit(_ sender: AnyObject) {
		form.submit()
	}
}

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return form.numberOfSections
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return form.sectionAtIndex(section).numberOfInputs
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let input = form.sectionAtIndex(indexPath.section).inputAtIndex(indexPath.row)
		
		if let input = input as? TextInput {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: TextInputTableViewCell.Identifier) as! TextInputTableViewCell
			cell.input = input
			
			return cell
			
		}
		
		if let input = input as? SelectInput {
			let cell = tableView.dequeueReusableCell(withIdentifier: SelectInputTableViewCell.Identifier) as! SelectInputTableViewCell
			cell.input = input
			return cell
		}
		return UITableViewCell()
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return nil
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.1
	}
}

