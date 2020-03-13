//
//  NameTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {
	
	private let nameTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Name"
		return textField
	}()
	
	private let customSeparatorView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .lightGray
		return view
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureView()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func requestName() -> String? {
		if nameTextField.text == "" || nameTextField.text == nil || nameTextField.text?.count ?? 0 < 1 {
			shake()
			return nil
		}
		return nameTextField.text
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(nameTextField)
		contentView.addSubview(customSeparatorView)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
			nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
			nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
		
		NSLayoutConstraint.activate([
			customSeparatorView.heightAnchor.constraint(equalToConstant: 1),
			customSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			customSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			customSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
	}
}
