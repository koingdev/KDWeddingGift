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
	
	// Observe when data added to reload WeddingGift tableView
	var didFinishAddData: (() -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Binding
		viewModel.name.bidirectionalBind(to: tfName.reactive.text)
		viewModel.dollarAmount.bidirectionalBind(to: tfAmountDollar.reactive.text)
		viewModel.rielAmount.bidirectionalBind(to: tfAmountRiel.reactive.text)
		
		// Event
		_ = btnAdd.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			self.viewModel.addWeddingGift { success in
				if success {
					self.didFinishAddData?()
					UIViewController.topMostViewController.dismiss(animated: true)
				}
				self.view.endEditing(true)
			}
		}
	}
	
}
