//
//  SignupLabelView.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class SignupLabelView: LoginLabelView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loginTitleLabel.text = "Please signup to the application"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
