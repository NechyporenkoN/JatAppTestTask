//
//  PasswordTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class PasswordTableViewCell: UITableViewCell {
	
	private let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = " Password"
		textField.isSecureTextEntry = true
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
	
	func requestPassword() -> String? {
		if passwordTextField.text == "" || passwordTextField.text == nil || passwordTextField.text?.count ?? 0 < 1 {
			shake()
			return nil
		}
		return passwordTextField.text
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(passwordTextField)
		contentView.addSubview(customSeparatorView)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
			passwordTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
			passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
		
		NSLayoutConstraint.activate([
			customSeparatorView.heightAnchor.constraint(equalToConstant: 1),
			customSeparatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			customSeparatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
			customSeparatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
		])
	}
}




