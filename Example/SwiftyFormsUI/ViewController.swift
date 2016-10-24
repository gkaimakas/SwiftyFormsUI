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
	@IBOutlet weak var selectInputPickerView: SelectInputPickerView!
	@IBOutlet weak var button: UIButton!
	
	let form = Form(name: "Form")
	let input = SelectInput(name: "durationInput")
		.addOptionWithDescription("option_gait_duration_15", value: "15")
		.addOptionWithDescription("option_gait_duration_30", value: "30")
		.addOptionWithDescription("option_gait_duration_60", value: "60")
		.addOptionWithDescription("option_gait_duration_120", value: "120")
		.addOptionWithDescription("option_gait_duration_180", value: "180")
		.addOptionWithDescription("option_gait_duration_240", value: "240")
		.addOptionWithDescription("option_gait_duration_300", value: "300")
		.addOptionWithDescription("option_gait_duration_360", value: "360")
		.addOptionWithDescription("option_gait_duration_420", value: "420")
		.addOptionWithDescription("option_gait_duration_480", value: "480")
		.addOptionWithDescription("option_gait_duration_540", value: "540")
		.addOptionWithDescription("option_gait_duration_600", value: "600")
		.addOptionWithDescription("option_gait_duration_660", value: "660")
		.addOptionWithDescription("option_gait_duration_720", value: "720")
		.addOptionWithDescription("option_gait_duration_780", value: "780")
		.addOptionWithDescription("option_gait_duration_840", value: "840")
		.addOptionWithDescription("option_gait_duration_900", value: "900")
		.selectOptionAtIndex(1)


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

		selectInputPickerView.input = input
		
    }

	@IBAction func handle(_ sender: AnyObject) {
		print(input.value)
	}
}

