//
//  TotalRecordVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class TotalRecordVC: UIViewController {
	
	@IBOutlet weak var lbRielTotal: UILabel!
	@IBOutlet weak var lbDollarTotal: UILabel!
	@IBOutlet weak var lbTotalCustomer: UILabel!
	@IBOutlet weak var btnScanQR: QRScannerButton!
	
	let viewModel = TotalRecordViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Event
		_ = btnScanQR.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			let vc = QRScannerVC.instantiate()
			self.present(vc, animated: true)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		Log.debug("Refresh total amount")
		// Refresh total
		lbRielTotal.text = viewModel.rielTotal
		lbDollarTotal.text = viewModel.dollarTotal
		lbTotalCustomer.text = viewModel.totalCustomer
	}
	
}
