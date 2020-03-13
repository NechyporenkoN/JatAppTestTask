//
//  ResultTableViewCell.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 13.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class ResultTableViewCell: UITableViewCell {
	
	private let characterTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Character:"
		return label
	}()
	
	private let counterTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Quantity:"
		return label
	}()
	
	private let characterResultLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.layer.borderColor = UIColor.lightGray.cgColor
		label.layer.borderWidth = 1
		label.layer.cornerRadius = 5
		return label
	}()
	
	private let counterResultLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.layer.borderColor = UIColor.lightGray.cgColor
		label.layer.borderWidth = 1
		label.layer.cornerRadius = 5
		return label
	}()
	
	private lazy var titleStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 4
		stack.addArrangedSubview(characterTitleLabel)
		stack.addArrangedSubview(counterTitleLabel)
		return stack
	}()
	
	private lazy var resultStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.spacing = 4
		stack.addArrangedSubview(characterResultLabel)
		stack.addArrangedSubview(counterResultLabel)
		return stack
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configureView()
		setConstraints()
	}
	
	func configure(data: ResultElement?) {
		guard let data = data, let number = data.number else { return }
		characterResultLabel.text = data.character
		counterResultLabel.text = String(number)
	}
	
	private func configureView() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.addSubview(titleStackView)
		contentView.addSubview(resultStackView)
	}
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			titleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
			titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -76)
		])
		
		NSLayoutConstraint.activate([
			resultStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
			resultStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
			resultStackView.leadingAnchor.constraint(equalTo: titleStackView.trailingAnchor, constant: 16),
			resultStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		characterResultLabel.text = nil
		counterResultLabel.text = nil
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
