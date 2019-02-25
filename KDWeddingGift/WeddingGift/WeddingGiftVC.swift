//
//  WeddingGiftVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class WeddingGiftVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	lazy var searchController = UISearchController(searchResultsController: nil)
	
	let viewModel = WeddingGiftViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Search bar
		searchController.searchResultsUpdater = self
		searchController.searchBar.placeholder = "ស្វែងរក"
		searchController.dimsBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.searchBar.tintColor = UIColor.main
		if #available(iOS 11.0, *) {
			definesPresentationContext = true
			navigationItem.searchController = searchController
			navigationItem.hidesSearchBarWhenScrolling = true
		} else {
			// Fallback on earlier versions
			tableView.tableHeaderView = searchController.searchBar
		}
	
		tableView.delegate = self
		tableView.dataSource = self
		
		// first time fetch
		viewModel.getAllDatas { [weak self] in
			Log.debug("First time get data from Realm")
			self?.tableView.reloadData()
		}
		
		// Observe search name
		// Debounce: Fire an event only if it's not followed by another event within 0.3 seconds
		_ = viewModel.searchName.skip(first: 2).debounce(interval: 0.3, on: .main).distinct().observeNext { [weak self] searchName in
			self?.viewModel.search(name: searchName) {
				Log.debug("Search name \(searchName)")
				self?.tableView.reloadData()
			}
		}
	}
	
}

// MARK: TableView

extension WeddingGiftVC: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - Delegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = AddFormVC.instantiate()
		
		// Filter ?
		if isFiltering() {
			// For update realm and list from AddForm
			vc.viewModel.weddingGiftRealmOjectForUpdate = viewModel.filteredDatas?[indexPath.row]
		} else {
			// For update realm and list from AddForm
			vc.viewModel.weddingGiftRealmOjectForUpdate = viewModel.datas?[indexPath.row]
		}
		
		vc.didFinishUpdateData = { [weak self] in
			self?.tableView.performAction(.reload, at: indexPath)
		}
		present(vc, animated: true)
		
		// Reset selection after 1sec
		Queue.runAfter(1) { [weak self] in
			self?.tableView.deselectRow(at: indexPath, animated: true)
		}
	}
	
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
							self?.tableView.performAction(.delete, at: indexPath)
							Log.debug("Delete data at index \(indexPath.row) succeed")
						}
					}.show()
		}
	}
	
	// MARK: - DataSource
	
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
			cell.configure(data: data)
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
