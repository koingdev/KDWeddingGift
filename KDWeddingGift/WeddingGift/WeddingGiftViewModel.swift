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
	var filteredDatas: Results<WeddingGiftRealmModel>?
	let searchName = Observable<String>("")
	
	let realmService: RealmDatabase!
	
	init(realmService: RealmDatabase = RealmService()) {
		self.realmService = realmService
	}
	
	var count: Int {
		return datas?.count ?? 0
	}
	
	var filteredCount: Int {
		return filteredDatas?.count ?? 0
	}
	
	func delete(object: Object, completion: () -> Void) {
		realmService.delete(object: object, completion: completion)
	}
	
	func search(name: String, completion: () -> Void) {
		WeddingGiftRealmModel.search(name: name) { filteredResult in
			self.filteredDatas = filteredResult
			completion()
		}
	}
	
	func getAllDatas(completion: @escaping () -> Void) {
		WeddingGiftRealmModel.getAll { datas in
			self.datas = datas
			completion()
		}
	}
	
}
