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

// MARK: CRUD

extension WeddingGiftRealmModel {
	
	static func write(object: Object, completion: ((Bool) -> Void)? = nil) {
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(object)
				completion?(true)
			}
		} catch {
			Log.error("Cannot insert data to Realm")
			completion?(false)
		}
	}
	
	static func delete(id: Int, completion: (Bool) -> Void) {
		do {
			let realm = try Realm()
			guard let object = realm.object(ofType: WeddingGiftRealmModel.self, forPrimaryKey: id) else {
				Log.debug("Cannot find AddFormRealmModel with key \(id)")
				completion(false)
				return
			}
			try realm.write {
				realm.delete(object)
				completion(true)
			}
		} catch {
			Log.error("Cannot delete data from Realm")
			completion(false)
		}
	}
	
	static func update(id: Int, name: String, dollarAmount: Double = 0, rielAmount: Double = 0, completion: ((Bool) -> Void)? = nil) {
		do {
			let realm = try Realm()
			guard let object = realm.object(ofType: WeddingGiftRealmModel.self, forPrimaryKey: id) else {
				Log.debug("Cannot find AddFormRealmModel with key \(id)")
				completion?(false)
				return
			}
			try realm.write {
				object.name = name
				object.dollarAmount = dollarAmount
				object.rielAmount = rielAmount
				completion?(true)
			}
		} catch {
			Log.error("Cannot update data to Realm")
			completion?(false)
		}
	}
	
	static func getAll(completion: @escaping (Results<WeddingGiftRealmModel>?) -> Void) {
		Queue.background {
			let realm = try! Realm()
			let object = realm.objects(WeddingGiftRealmModel.self).sorted(byKeyPath: "id", ascending: false)
			// Passing instances across threads
			let objectRef = ThreadSafeReference(to: object)
			Queue.main {
				let realm = try! Realm()
				guard let object = realm.resolve(objectRef) else {
					completion(nil)
					return
				}
				completion(object)
			}
		}
	}
	
}
