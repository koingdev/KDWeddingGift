//
//  WeddingGiftFormVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class WeddingGiftFormVC: UIViewController {
	
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var tfAmountDollar: UITextField!
	@IBOutlet weak var tfAmountRiel: UITextField!
	
	@IBOutlet weak var btnAdd: UIButton!
	let viewModel = WeddingGiftFormViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Binding
		viewModel.name.bidirectionalBind(to: tfName.reactive.text)
		viewModel.dollarAmount.bidirectionalBind(to: tfAmountDollar.reactive.text)
		
		// Event
		_ = btnAdd.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			guard self.viewModel.isFormValid() else {
				self.view.endEditing(true)
				return
			}
			// Valid ?
			
		}
	}
	
}
