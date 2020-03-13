//
//  LoginTableViewController.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

class LoginTableViewController: UITableViewController {
	
	private var presenter: LoginTablePresenterDelegate?
	private var isLoggingIn = false
	private var activityIndicator: UIActivityIndicatorView!
	private let loadingView: UIView = UIView()
	private let container: UIView = UIView()
	
	init() {
		super.init(style: .grouped)
		presenter = LoginTablePresenter(view: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
		configureSpinner()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
		showResultsController()
	}
	
	private func configureView() {
		
		tableView.keyboardDismissMode = .interactive
		tableView.separatorStyle = .none
		let titleView = LoginLabelView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
		tableView.tableHeaderView = titleView
		tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150)
		
		tableView.register(EmailTableViewCell.self, forCellReuseIdentifier: String(describing: EmailTableViewCell.self))
		tableView.register(PasswordTableViewCell.self, forCellReuseIdentifier: String(describing: PasswordTableViewCell.self))
		tableView.register(LoginButtonTableViewCell.self, forCellReuseIdentifier: String(describing: LoginButtonTableViewCell.self))
		tableView.register(SignupButtonTableViewCell.self, forCellReuseIdentifier: String(describing: SignupButtonTableViewCell.self))
	}
	
	private func configureSpinner() {
		
    container.frame = view.frame
    container.center = view.center
		container.backgroundColor = .white
		container.alpha = 0.6

		loadingView.frame = CGRect(x: view.center.x - 40, y: view.center.y - 80, width: 80, height: 80)
		loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
		loadingView.alpha = 0.7
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10

    activityIndicator = UIActivityIndicatorView()
		activityIndicator.center = view.center
		activityIndicator.frame = CGRect(x: 20, y: 20, width: 40.0, height: 40.0)
		activityIndicator.style = UIActivityIndicatorView.Style.large
		activityIndicator.color = .white
    loadingView.addSubview(activityIndicator)
    container.addSubview(loadingView)
    tableView.addSubview(container)
		container.isHidden = true
	}
	
	private func showResultsController() {
		
		guard let token = UserDefaults.standard.string(forKey: "Token") else { return }
		let destination = ResultsTableViewController(token: token)
		navigationController?.show(destination, sender: self)
	}
	
	private func showAlertController(message: String?) {
		
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	private func startActivityIndicator() {
		
		container.isHidden = false
		activityIndicator.startAnimating()
	}
	
	private func stopActivityIndicator() {
		
		activityIndicator.stopAnimating()
		container.isHidden = true
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cellType = presenter?.dataSource[indexPath.row] else { return UITableViewCell()}
		
		switch cellType {
		case .email:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmailTableViewCell.self), for: indexPath) as! EmailTableViewCell
			return cell
		case .password:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PasswordTableViewCell.self), for: indexPath) as! PasswordTableViewCell
			return cell
		case .login:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoginButtonTableViewCell.self), for: indexPath) as! LoginButtonTableViewCell
			cell.delegate = self
			return cell
		case .signup:
			let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SignupButtonTableViewCell.self), for: indexPath) as! SignupButtonTableViewCell
			cell.signupActionDelegate = self
			return cell
		default:
			return UITableViewCell()
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		let cellType = presenter?.dataSource[indexPath.row]
		switch cellType {
		case .login:
			return 144
		case .signup:
			return 88
		default:
			return 44
		}
	}
}

extension LoginTableViewController: LoginTableViewDelegate {
	
	func userEmailDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EmailTableViewCell else {
			return nil
		}
		return cell.requestEmail()
	}
	
	func userPasswordDidRequest() -> String? {
		
		guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? PasswordTableViewCell else {
			return nil
		}
		return cell.requestPassword()
	}
}

extension LoginTableViewController: SignupButtonTableViewCellDelegate {
	
	func signupButtonDidTap() {
		
		let controller = SignupTableViewController()
		let navigationController = UINavigationController(rootViewController: controller)
		navigationController.modalPresentationStyle = .fullScreen
		present(navigationController, animated: true, completion: nil)
	}
}

extension LoginTableViewController: LoginButtonTableViewCellDelegate {
	
	func loginButtonDidTap() {
		
		guard let email = userEmailDidRequest(), let password = userPasswordDidRequest() else { return }
		startActivityIndicator()
		if !isLoggingIn {
			isLoggingIn = true
			print(email, password)
			presenter?.loginRequest(email: email, password: password, with: { [weak self] (status, message) in
				
				DispatchQueue.main.async {
					if status {
						self?.showResultsController()
					} else {
						self?.showAlertController(message: message)
					}
					self?.isLoggingIn = false
					self?.stopActivityIndicator()
				}
			})
		}
	}
}
