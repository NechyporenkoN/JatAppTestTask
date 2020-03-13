//
//  LoginLabelView.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class LoginLabelView: UIView {
	
	let loginTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Please sign in to the application"
		label.font = UIFont.systemFont(ofSize: 20)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}
	
	private func configureView() {
		
		addSubview(loginTitleLabel)
		
		loginTitleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
		loginTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		loginTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		loginTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
