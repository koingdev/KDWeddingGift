//
//  WeddingGiftFormViewModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Bond

final class WeddingGiftFormViewModel {
	
	let name = Observable<String?>("")
	var dollarAmount = Observable<String?>("")
	var rielAmount = Observable<String?>("")
	
	func isFormValid() -> Bool {
		let isNameEmpty = name.value?.isEmpty ?? true
		let isDollarAmountEmpty = dollarAmount.value?.isEmpty ?? true
		let isRielAmountEmpty = rielAmount.value?.isEmpty ?? true
		return isNameEmpty && (isDollarAmountEmpty || isRielAmountEmpty)
	}
	
}
