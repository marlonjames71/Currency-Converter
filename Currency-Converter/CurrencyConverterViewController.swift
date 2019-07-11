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
	let layer = CAGradientLayer()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		CADButton.isSelected = true
		toCurrencyLabel.text = CurrencyType.cad.rawValue
		layer.frame = view.bounds
		layer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
		view.layer.insertSublayer(layer, at: 0)
		convertButton.layer.cornerRadius = 20
		usdCurrencyTextField.textColor = .white
		otherCurrencyTextField.textColor = .white
		let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
		toolbar.barTintColor = .clear
		let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
		let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
		doneBtn.tintColor = .white
		toolbar.setItems([flexSpace, doneBtn], animated: false)
		toolbar.sizeToFit()
		self.usdCurrencyTextField.inputAccessoryView = toolbar
		usdCurrencyTextField.addTarget(self, action: #selector(usdCurrencyEdited(_:)), for: .editingChanged)
	}

	@objc func doneButtonAction() {
		self.view.endEditing(true)
	}
	
	// MARK: - Actions
	@IBAction func convertButtonTapped(_ sender: UIButton) {
		let validCharacters = Set("1234567890")
		guard let currencyStr = usdCurrencyTextField.text,
			let usdCurrency = Double(currencyStr.filter{ validCharacters.contains($0) }) else { return }
		if CADButton.isSelected == true {
			otherCurrencyTextField.text = currencyFormatter.string(from: (NSNumber(value: convert(dollars: usdCurrency, to: .cad) / 100)))
		} else {
			otherCurrencyTextField.text = currencyFormatter.string(from: (NSNumber(value: convert(dollars: usdCurrency, to: .mxn) / 100)))
		}
	}
	
	@IBAction func usdCurrencyEdited(_ sender: UITextField) {
		guard let usdCurrencyStr = sender.text else { return }
		print(sender.text!)
		let validCharacters = Set("1234567890")
		let sanitizedStr = usdCurrencyStr.filter { validCharacters.contains($0) }
		print(sanitizedStr)
		guard let value = Double(sanitizedStr) else { return }
		usdCurrencyTextField.text = currencyFormatter.string(from: NSNumber(value: value / 100))
	}
	
	@IBAction func CADButtonSelected(_ sender: UIButton) {
		CADButton.isSelected = true
		MXNButton.isSelected = false
		toCurrencyLabel.text = CurrencyType.cad.rawValue
		convertButtonTapped(sender)
	}
	
	@IBAction func MXNButtonSelected(_ sender: UIButton) {
		MXNButton.isSelected = true
		CADButton.isSelected = false
		toCurrencyLabel.text = CurrencyType.mxn.rawValue
		convertButtonTapped(sender)
	}
	

	// MARK: - Helper Functions
	/*
	As of July 10th 2019
	$1 USD to $1.31 CAD
	$1 USD to $19.17 MXN
	*/
	
	let currencyFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		return formatter
	}()
	

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


//extension String {
//	func
//}
