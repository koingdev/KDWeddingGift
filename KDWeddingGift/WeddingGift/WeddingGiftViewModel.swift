//
//  WeddingGiftViewModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import Bond
import RealmSwift

final class WeddingGiftViewModel {
	
	var datas: Results<WeddingGiftRealmModel>?
	
	var count: Int {
		return datas?.count ?? 0
	}
	
	func getDollarAmount(index: Int) -> Double {
		return datas?[index].dollarAmount ?? 0
	}
	
	func getRietAmount(index: Int) -> Double {
		return datas?[index].rielAmount ?? 0
	}
	
	func getAllDatas(completion: @escaping () -> Void) {
		WeddingGiftRealmModel.getAll { datas in
			self.datas = datas
			completion()
		}
	}
	
}
