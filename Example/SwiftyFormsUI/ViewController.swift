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
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		tableView.registerNib(TextInputTableViewCell.Nib, forCellReuseIdentifier: TextInputTableViewCell.Identifier)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 40.0
		tableView.dataSource = self
		tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(TextInputTableViewCell.Identifier) as! TextInputTableViewCell
		return cell
	}
}

extension ViewController: UITableViewDelegate {
	
}

