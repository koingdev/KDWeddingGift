//
//  AddFormVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class AddFormVC: UIViewController {
	
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfAmountDollar: UITextField!
	@IBOutlet weak var tfAmountRiel: UITextField!
	@IBOutlet weak var btnAdd: UIButton!
	
	let viewModel = AddFormViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Binding
		viewModel.name.bidirectionalBind(to: tfName.reactive.text)
		viewModel.dollarAmount.bidirectionalBind(to: tfAmountDollar.reactive.text)
		viewModel.rielAmount.bidirectionalBind(to: tfAmountRiel.reactive.text)
		
		// Event
		_ = btnAdd.reactive.controlEvents(.touchUpInside).throttle(seconds: 1).observeNext { [weak self] in
			guard let self = self else { return }
			self.viewModel.submitWeddingGift { success in
				if success {
					UIViewController.topMostViewController.dismiss(animated: true)
				} else {
					Log.warning("Submit data failed")
				}
				self.view.endEditing(true)
			}
		}
	}
	
}
