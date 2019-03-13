//
//  AddFormViewModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Bond

final class AddFormViewModel {
	
	// Receive data from tableview datasource when user tap on any row
	// For update
	var weddingGiftRealmOjectForUpdate: WeddingGiftRealmModel? {
		didSet {
			// Set form value
			name.value = weddingGiftRealmOjectForUpdate?.name
			let dollar = weddingGiftRealmOjectForUpdate?.dollarAmount ?? 0
			dollarAmount.value = String(describing: dollar)
			let riel = weddingGiftRealmOjectForUpdate?.rielAmount ?? 0
			rielAmount.value = String(describing: riel)
		}
	}
	
	// Binding
	let name = Observable<String?>("")
	var dollarAmount = Observable<String?>("")
	var rielAmount = Observable<String?>("")
	
	private let realmService: RealmService!
	
	init(realmService: RealmService = RealmService()) {
		self.realmService = realmService
	}
	
	// Getter
	private var getName: String {
		return name.value?.trimmingCharacters(in: .whitespaces) ?? ""
	}
	private var getDollarAmount: Double {
		let dollar = Double(dollarAmount.value ?? "") ?? 0.0
		return dollar
	}
	private var getRielAmount: Double {
		let riel = Double(rielAmount.value ?? "") ?? 0.0
		return riel
	}
	
	func isMoneyValid() -> Bool {
		// Input money more than one dot ?
		let isValidDollar = (dollarAmount.value?.filter { $0 == "." }.count ?? 0) <= 1
		let isValidRiel = (rielAmount.value?.filter { $0 == "." }.count ?? 0) <= 1
		return isValidDollar && isValidRiel
	}
	
	func isFormValid() -> Bool {
		// Not empty ?
		let isNameNotEmpty = !getName.isEmpty
		let isDollarAmountNotEmpty = getDollarAmount > 0
		let isRielAmountNotEmpty = getRielAmount > 0
		return isMoneyValid() && isNameNotEmpty && (isDollarAmountNotEmpty || isRielAmountNotEmpty)
	}
	
	func isUpdateForm() -> Bool {
		return weddingGiftRealmOjectForUpdate != nil
	}
	
	func updateWeddingGift(completion: (Bool) -> Void) {
		if isFormValid() {
			// Update operation
			guard let object = weddingGiftRealmOjectForUpdate else {
				Log.warning("Cannot update because weddingGiftRealmOjectForUpdate is nil")
				return
			}
			realmService.updateBlock {
				// updated value
				object.name = getName
				object.dollarAmount = getDollarAmount
				object.rielAmount = getRielAmount
				completion(true)
			}
		} else {
			completion(false)
		}
	}
	
	func addNewWeddingGift(completion: (Bool) -> Void) {
		if isFormValid() {
			let object = WeddingGiftRealmModel(name: getName, dollarAmount: getDollarAmount, rielAmount: getRielAmount)
			realmService.add(object: object)
			completion(true)
		} else {
			completion(false)
		}
	}
	
}
