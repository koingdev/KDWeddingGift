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
	
	let viewModel = TotalRecordViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Get total first time
		setTotals()
		
		// Realm data change ?
		viewModel.observeWeddingGiftRealmModel { [weak self] in
			self?.setTotals()
			Log.debug("Refresh total")
		}
	}
	
	private func setTotals() {
		lbRielTotal.text = viewModel.rielTotal
		lbDollarTotal.text = viewModel.dollarTotal
		lbTotalCustomer.text = viewModel.totalCustomer
	}
	
}
