//
//  ViewController.swift
//  Currency-Converter
//
//  Created by Marlon Raskin on 7/10/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

enum CurrencyType: String {
	case cad = "Currency (CAD)"
	case mxn = "Currency (MXN)"
}

class CurrencyConverterViewController: UIViewController {

	// MARK: - Outlets and Properties
	@IBOutlet weak var usdCurrencyTextField: UITextField!
	@IBOutlet weak var otherCurrencyTextField: UITextField!
	@IBOutlet weak var toCurrencyLabel: UILabel!
	@IBOutlet weak var convertButton: UIButton!
	@IBOutlet weak var CADButton: UIButton!
	@IBOutlet weak var MXNButton: UIButton!
	
	var currencyType: CurrencyType = .cad
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		CADButton.isSelected = true
		toCurrencyLabel.text = CurrencyType.cad.rawValue
	}
	
	// MARK: - Actions
	@IBAction func convertButtonTapped(_ sender: UIButton) {
		
	}
	@IBAction func CADButtonSelected(_ sender: UIButton) {
		CADButton.isSelected = true
		MXNButton.isSelected = false
		toCurrencyLabel.text = CurrencyType.cad.rawValue
	}
	@IBAction func MXNButtonSelected(_ sender: UIButton) {
		MXNButton.isSelected = true
		CADButton.isSelected = false
		toCurrencyLabel.text = CurrencyType.mxn.rawValue
	}
	

	// MARK: - Helper Functions
	//$1 USD to $1.31 CAD
	//$1 USD to $19.17 MXN

	func convert(dollars: Double, to unit: CurrencyType) -> Double {
		var product: Double
		switch unit {
		case .cad:
			product = dollars * 1.31
		case .mxn:
			product = dollars * 19.17
		}
		return product
	}
}

