//
//  QRScannerVC.swift
//  KDWeddingGift
//
//  Created by KoingDev on 2/7/19.
//  Copyright © 2019 KoingDev. All rights reserved.
//

import UIKit

final class QRScannerVC: UIViewController {
	
	@IBOutlet weak var videoPreview: UIView!
	private var videoLayer: CALayer!
	
	private var qrCodeReader = AVQRCodeReader()
	
	// Observe when data added to reload WeddingGift tableView
	var didFinishAddData: (() -> Void)?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		videoLayer = qrCodeReader.videoPreview
		videoPreview.layer.addSublayer(videoLayer)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		videoLayer.frame = videoPreview.bounds
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		qrCodeReader.startReading { [weak self] name in
			let vc = AddFormVC.instantiate()
			vc.didFinishAddData = self?.didFinishAddData
			self?.present(vc, animated: true) {
				vc.viewModel.name.value = name
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		qrCodeReader.stopReading()
	}
	
}
