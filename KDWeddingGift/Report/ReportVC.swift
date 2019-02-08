//
//  ReportVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/8/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit
import Bond

final class ReportVC: UIViewController {
	
	@IBOutlet weak var btnScanQR: QRScannerButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Event
		_ = btnScanQR.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
			guard let self = self else { return }
			let vc = QRScannerVC.instantiate()
			self.present(vc, animated: true)
		}
	}
	
}
