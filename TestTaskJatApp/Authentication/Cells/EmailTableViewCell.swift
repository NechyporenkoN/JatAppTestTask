//
//  EmailTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {
	
	private let emailTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = "Email"
		textField.keyboardType = .emailAddress
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
	
	func requestEmail() -> String? {
		if emailTextField.text == "" || emailTextField.text == nil || emailTextField.text?.count ?? 0 < 1 {
			shake()
			return nil
		}
		return emailTextField.text
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(emailTextField)
		contentView.addSubview(customSeparatorView)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
			emailTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
			emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
		
		NSLayoutConstraint.activate([
			customSeparatorView.heightAnchor.constraint(equalToConstant: 1),
			customSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			customSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			customSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
	}
}
