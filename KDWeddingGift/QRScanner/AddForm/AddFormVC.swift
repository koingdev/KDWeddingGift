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
	@IBOutlet weak var lbError: UILabel!
	
	var didFinishAddNewData: (() -> Void)?
	var didFinishUpdateData: (() -> Void)?
	let viewModel = AddFormViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Delegate
		tfAmountRiel.delegate = self
		tfAmountDollar.delegate = self
		
		// Binding
		viewModel.name.bidirectionalBind(to: tfName.reactive.text)
		viewModel.dollarAmount.bidirectionalBind(to: tfAmountDollar.reactive.text)
		viewModel.rielAmount.bidirectionalBind(to: tfAmountRiel.reactive.text)
		
		// Event
		_ = btnAdd.reactive.controlEvents(.touchUpInside).throttle(seconds: 1).observeNext { [weak self] in
			guard let self = self else { return }
			
			// Update
			if self.viewModel.isUpdateForm() {
				self.viewModel.updateWeddingGift { success in
					if success {
						self.didFinishUpdateData?()
						UIViewController.topMostViewController.dismiss(animated: true)
						Log.debug("Update data succeed")
					} else {
						Log.warning("Update data failed")
					}
					// error label
					self.lbError.isHidden = success
				}
				
			} else { // Add new
				self.viewModel.addNewWeddingGift { success in
					if success {
						self.didFinishAddNewData?()
						UIViewController.topMostViewController.dismiss(animated: true)
						Log.debug("Add new data succeed")
					} else {
						Log.warning("Add new data failed")
					}
					// error label
					self.lbError.isHidden = success
				}
			}
			
			self.view.endEditing(true)
		}
	}
	
}

// MARK: TextField Delegate

extension AddFormVC: UITextFieldDelegate {
	
	// Restrict user input, allow only decimal
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let invalidCharacters = CharacterSet(charactersIn: ".0123456789").inverted
		return string.rangeOfCharacter(from: invalidCharacters) == nil
	}
	
}
