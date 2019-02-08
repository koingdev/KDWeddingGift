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
		
		tableView.dataSource = self
		
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.datas?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(of: WeddingGiftTableViewCell.self, for: indexPath) { [weak self] cell in
			guard let self = self else { return }
			if let data = self.viewModel.datas?[indexPath.row] {
				cell.lbName.text = data.name
				cell.setRielAmount(data.rielAmount)
				cell.setDollarAmount(data.dollarAmount)
			}
		}
		return cell
	}
	
}
