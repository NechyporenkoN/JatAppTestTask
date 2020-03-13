//
//  SignupButtonTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol SignupButtonTableViewCellDelegate: class {
	func signupButtonDidTap()
}

class SignupButtonTableViewCell: UITableViewCell {
	
	weak var signupActionDelegate: SignupButtonTableViewCellDelegate?
	
	lazy var signupButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Signup", for: .normal)
		button.setTitleColor(Colors.specilBlue, for: .normal)
		button.layer.borderColor = Colors.specilBlue.cgColor
		button.layer.borderWidth = 2
		button.layer.cornerRadius = 22
		button.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
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
		contentView.addSubview(signupButton)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			signupButton.heightAnchor.constraint(equalToConstant: 44),
			signupButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			signupButton.widthAnchor.constraint(equalToConstant: frame.width/2),
			signupButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
	}
	
	@objc func signupButtonPressed() {
		signupActionDelegate?.signupButtonDidTap()
	}
}
