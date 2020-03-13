//
//  SignupTableViewController.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class SignupTableViewController: UITableViewController {
	
	private var presenter: SignupTablePresenterDelegate?
	
	init() {
		super.init(style: .grouped)
		presenter = SignupTablePresenter(view: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	
	private func configureView() {
		
		tableView.keyboardDismissMode = .interactive
		tableView.separatorStyle = .none
		let titleView = SignupLabelView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
		tableView.tableHeaderView = titleView
		tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150)
		
		tableView.register(NameTableViewCell.self, forCellReuseIdentifier: String(describing: NameTableViewCell.self))
		tableView.register(EmailTableViewCell.self, forCellReuseIdentifier: String(describing: EmailTableViewCell.self))
		tableView.register(PasswordTableViewCell.self, forCellReuseIdentifier: String(describing: PasswordTableViewCell.self))
		tableView.register(LoginButtonTableViewCell.self, forCellReuseIdentifier: String(describing: LoginButtonTableViewCell.self))
		tableView.register(SignupTableViewCell.self, forCellReuseIdentifier: String(describing: SignupTableViewCell.self))
		
		let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonPresed))
		navigationItem.leftBarButtonItem = cancelBarButton
	}
	
	private func showAlertController(message: String?) {
		
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	@objc func cancelBarButtonPresed() {
		dismiss(animated: true, completion: nil)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cellType = presenter?.dataSource[indexPath.row] else { return UITableViewCell()}
		
		switch cellType {
		case .name:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NameTableViewCell.self), for: indexPath) as! NameTableViewCell
			return cell
		case .email:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmailTableViewCell.self), for: indexPath) as! EmailTableViewCell
			return cell
		case .password:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PasswordTableViewCell.self), for: indexPath) as! PasswordTableViewCell
			return cell
		case .signup:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SignupTableViewCell.self), for: indexPath) as! SignupTableViewCell
			cell.signupCompletionDelegate = self
			cell.configure()
			return cell
		default:
			return UITableViewCell()
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		let cellType = presenter?.dataSource[indexPath.row]
		switch cellType {
		case .signup:
			return 144
		default:
			return 44
		}
	}
}

// MARK: - SignupTableViewDelegate
extension SignupTableViewController: SignupTableViewDelegate {
	
	func userNameDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NameTableViewCell else {
			return nil
		}
		return cell.requestName()
	}
	
	func userEmailDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EmailTableViewCell else {
			return nil
		}
		return cell.requestEmail()
	}
	
	func userPasswordDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? PasswordTableViewCell else {
			return nil
		}
		return cell.requestPassword()
	}
}

extension SignupTableViewController: SignupTableViewCellDelegate {
	
	func signupDidTap() {
		
		guard let name = userNameDidRequest(), let email = userEmailDidRequest(), let password = userPasswordDidRequest() else { return }
		presenter?.signupRequest(name: name, email: email, password: password, with: { [weak self] (status, message) in
			DispatchQueue.main.async {
				if status {
					self?.dismiss(animated: true, completion: {
					})
				} else {
					self?.showAlertController(message: message)
				}
			}
		})
	}
}

