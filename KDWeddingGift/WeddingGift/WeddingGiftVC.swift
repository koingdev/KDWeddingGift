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
	@IBOutlet weak var btnScanQR: QRScannerButton!
	
	let viewModel = WeddingGiftViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self
		
		// first time fetch
		viewModel.getAllDatas { [weak self] in
			self?.tableView.reloadData()
		}
		
		// Event
		_ = btnScanQR.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			let vc = QRScannerVC.instantiate()
			vc.didFinishAddData = {
				Log.debug("FINISH SUBMIT")
				self.tableView.reloadData()
			}
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
			let id = data.id
			UIAlertController.alertOkayCancel(title: "តើអ្នកពិតជាចង់លុបទិន្នន័យឈ្មោះ \(data.name)?") { [weak self] _ in
				self?.viewModel.delete(id: id) { success in
					if success {
						tableView.reloadData()
					} else {
						Log.warning("Delete data at index \(indexPath.row) failed")
					}
				}
			}
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(of: WeddingGiftTableViewCell.self, for: indexPath) { [weak self] cell in
			guard let self = self else { return }
			let index = indexPath.row
			cell.configure(data: self.viewModel.datas?[index]) {
				let vc = AddFormVC.instantiate()
				_ = vc.view	// force view to render
				
				// For update realm and list from AddForm
				vc.viewModel.idForUpdate = self.viewModel.datas?[index].id ?? 0
				vc.viewModel.name.value = self.viewModel.datas?[index].name
				let dollarAmount = self.viewModel.getDollarAmount(index: index)
				if dollarAmount > 0 {
					vc.viewModel.dollarAmount.value = "\(dollarAmount)"
				}
				let rielAmount = self.viewModel.getRietAmount(index: index)
				if rielAmount > 0 {
					vc.viewModel.rielAmount.value = "\(rielAmount)"
				}
				vc.didFinishAddData = {
					Log.debug("FINISH UPDATE")
					self.tableView.reloadData()
				}
				self.present(vc, animated: true)
			}
		}
		return cell
	}
	
}
