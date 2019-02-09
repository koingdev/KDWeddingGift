//
//  WeddingGiftVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond
import RealmSwift

final class WeddingGiftVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var btnScanQR: QRScannerButton!
	lazy var searchController = UISearchController(searchResultsController: nil)
	
	let viewModel = WeddingGiftViewModel()
	
	var notificationToken: NotificationToken?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Search bar
		if #available(iOS 11.0, *) {
			searchController.searchResultsUpdater = self
			searchController.searchBar.placeholder = "ស្វែងរក"
			searchController.obscuresBackgroundDuringPresentation = false
			navigationItem.searchController = searchController
			navigationItem.hidesSearchBarWhenScrolling = true
			definesPresentationContext = true
		} else {
			// Fallback on earlier versions
		}
		
		tableView.delegate = self
		tableView.dataSource = self
		
		// first time fetch
		viewModel.getAllDatas { [weak self] in
			Log.debug("First time get data from Realm")
			self?.tableView.reloadData()
		}
		
		// Observe realm db update
		viewModel.observeWeddingGiftRealmModel { [weak self] in
			Log.debug("WeddingGiftRealmModel database updated")
			self?.tableView.reloadData()
		}
		
		// Observe search name
		#warning("Implement throttle search ??")
		_ = viewModel.searchName.skip(first: 2).distinct().observeNext { [weak self] searchName in
			self?.viewModel.search(name: searchName) {
				Log.debug("Search name \(searchName)")
				self?.tableView.reloadData()
			}
		}
		
		// Event
		_ = btnScanQR.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			let vc = QRScannerVC.instantiate()
			self.present(vc, animated: true)
		}
	}
	
}

// MARK: Delegate

extension WeddingGiftVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			guard let data = viewModel.datas?[indexPath.row] else {
				Log.warning("No data to delete at index \(indexPath.row)")
				return
			}
			
			UIAlertController.Builder()
					.withTitleAndMessage(title: "តើអ្នកពិតជាចង់លុបទិន្នន័យឈ្មោះ \(data.name)?")
					.addAction(title: "ទេ", style: .cancel)
					.addAction(title: "ព្រម", style: .destructive) { [weak self] _ in
						self?.viewModel.delete(object: data) {
							Log.debug("Delete data at index \(indexPath.row) succeed")
						}
					}.show()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering() {
			return viewModel.filteredCount
		}
		return viewModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(of: WeddingGiftTableViewCell.self, for: indexPath) { [weak self] cell in
			guard let self = self else { return }
			let index = indexPath.row
			var data: WeddingGiftRealmModel?
			// Filter ?
			if self.isFiltering() {
				data = viewModel.filteredDatas?[index]
			} else {
				data = viewModel.datas?[index]
			}
			
			cell.configure(data: data) {
				// Tap on cell action
				let vc = AddFormVC.instantiate()
				// For update realm and list from AddForm
				vc.viewModel.weddingGiftRealmOjectForUpdate = data
				self.present(vc, animated: true)
			}
		}
		return cell
	}
	
}

// MARK: Search Controller

extension WeddingGiftVC: UISearchResultsUpdating {
	
	func isFiltering() -> Bool {
		let isSearchBarNotEmpty = !(searchController.searchBar.text?.isEmpty ?? true)
		return searchController.isActive && isSearchBarNotEmpty
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		viewModel.searchName.value = searchController.searchBar.text ?? ""
	}
	
}
