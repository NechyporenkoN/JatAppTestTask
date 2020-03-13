//
//  LoginButtonTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol LoginButtonTableViewCellDelegate: class {
	func loginButtonDidTap()
}

class LoginButtonTableViewCell: UITableViewCell {
	
	weak var delegate: LoginButtonTableViewCellDelegate?
	
	lazy var loginButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Login", for: .normal)
		button.setTitleColor(Colors.specialGreen, for: .normal)
		button.layer.borderColor = Colors.specialGreen.cgColor
		button.layer.borderWidth = 2
		button.layer.cornerRadius = 22
		button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureView()
		setConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(loginButton)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			loginButton.heightAnchor.constraint(equalToConstant: 44),
			loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			loginButton.widthAnchor.constraint(equalToConstant: frame.width/2),
			loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}
	
	@objc func loginButtonPressed() {
		delegate?.loginButtonDidTap()
	}
}
