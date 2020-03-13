//
//  SignupTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

protocol SignupTableViewCellDelegate: class {
	func signupDidTap()
}

class SignupTableViewCell: SignupButtonTableViewCell {
	
	weak var signupCompletionDelegate: SignupTableViewCellDelegate?
	
	func configure() {
		signupButton.setTitleColor(Colors.specialGreen, for: .normal)
		signupButton.layer.borderColor = Colors.specialGreen.cgColor
		signupButton.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
	}
	
	@objc func buttonDidTap() {
		signupCompletionDelegate?.signupDidTap()
	}
}
