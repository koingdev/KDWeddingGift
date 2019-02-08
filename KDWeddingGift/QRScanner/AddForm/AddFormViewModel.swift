//
//  AddFormViewModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Bond

final class AddFormViewModel {
	
	// Binding
	let name = Observable<String?>("")
	var dollarAmount = Observable<String?>("")
	var rielAmount = Observable<String?>("")
	
	// Getter
	private var getName: String {
		return name.value ?? ""
	}
	private var getDollarAmount: Double {
		let dollar = Double(dollarAmount.value ?? "") ?? 0.0
		return dollar
	}
	private var getRielAmount: Double {
		let riel = Double(rielAmount.value ?? "") ?? 0.0
		return riel
	}
	
	func isFormValid() -> Bool {
		let isNameNotEmpty = !getName.isEmpty
		let isDollarAmountNotEmpty = getDollarAmount > 0
		let isRielAmountNotEmpty = getRielAmount > 0
		return isNameNotEmpty && (isDollarAmountNotEmpty || isRielAmountNotEmpty)
	}
	
	func addWeddingGift(completion: ((Bool) -> Void)? = nil) {
		if isFormValid() {
			let object = WeddingGiftRealmModel(name: getName, dollarAmount: getDollarAmount, rielAmount: getRielAmount)
			WeddingGiftRealmModel.write(object: object)
			completion?(true)
		} else {
			completion?(false)
		}
	}
	
}
