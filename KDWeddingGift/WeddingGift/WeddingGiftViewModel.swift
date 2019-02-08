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
	
	func getAllDatas(completion: @escaping () -> Void) {
		WeddingGiftRealmModel.getAll { datas in
			self.datas = datas
			completion()
		}
	}
	
}
