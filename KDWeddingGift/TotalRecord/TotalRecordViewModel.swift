//
//  TotalRecordViewModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/9/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Foundation

final class TotalRecordViewModel {
	
	var rielTotal: String {
		return "\(WeddingGiftRealmModel.getRielTotal()) រៀល"
	}
	
	var dollarTotal: String {
		return "\(WeddingGiftRealmModel.getDollarTotal()) ដុល្លា"
	}
	
	var totalCustomer: String {
		return "\(WeddingGiftRealmModel.getTotalCustomer()) នាក់"
	}
	
	private let realmService: RealmService!
	
	init(realmService: RealmService = RealmService()) {
		self.realmService = realmService
	}
	
	func observeWeddingGiftRealmModel(completion: @escaping () -> Void) {
		realmService.observeDatabaseChanged(completion: completion)
	}
	
}
