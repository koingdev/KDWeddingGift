//
//  AddFormRealmModel.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import RealmSwift

class WeddingGiftRealmModel: Object {
	
	@objc dynamic var id = 0
	@objc dynamic var name: String = ""
	@objc dynamic var dollarAmount: Double = 0.0
	@objc dynamic var rielAmount: Double = 0.0
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	// Generate auto-increment id manually
	fileprivate func incrementID() -> Int {
		let realm = try! Realm()
		return (realm.objects(WeddingGiftRealmModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
	}
	
	convenience init(name: String, dollarAmount: Double = 0, rielAmount: Double = 0) {
		self.init()
		self.id = incrementID()
		self.name = name
		self.dollarAmount = dollarAmount
		self.rielAmount = rielAmount
	}
	
}

extension WeddingGiftRealmModel {
	
	static func getAll(completion: @escaping (Results<WeddingGiftRealmModel>) -> Void) {
		Queue.background {
			let realm = try! Realm()
			let object = realm.objects(WeddingGiftRealmModel.self).sorted(byKeyPath: "id", ascending: false)
			// Passing instances across threads
			let objectRef = ThreadSafeReference(to: object)
			Queue.main {
				let realm = try! Realm()
				guard let object = realm.resolve(objectRef) else {
					return
				}
				completion(object)
			}
		}
	}
	
	static func search(name: String, completion: (Results<WeddingGiftRealmModel>) -> Void) {
		let realm = try! Realm()
		let result = realm.objects(WeddingGiftRealmModel.self).filter("name CONTAINS %@", name)
		completion(result)
	}
	
}
