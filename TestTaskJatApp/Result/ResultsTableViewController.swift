//
//  ResultsTableViewController.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 12.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

final class ResultsTableViewController: UITableViewController {
	
	private var presenter: ResultsTablePresenterDelegate?
	
	init(token: String?) {
		super.init(style: .grouped)
		presenter = ResultsTablePresenter(view: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureView()
	}
	
	private func configureView() {
		
		navigationController?.setNavigationBarHidden(false, animated: false)
		
		let logOutBarButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonPressed))
		navigationItem.rightBarButtonItem = logOutBarButton
		let localetBarButton = UIBarButtonItem(title: "Locale", style: .plain, target: self, action: #selector(changeLocale))
		navigationItem.leftBarButtonItem = localetBarButton
		navigationItem.hidesBackButton = true
		
		tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: String(describing: ResultTableViewCell.self))
	}
	
	private func showAlertController(message: String?) {
		
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	private func showActionSheet() {
		
		let alert = UIAlertController(title: nil, message: "Select desirable locale", preferredStyle: .actionSheet)
		
		Locales.list.forEach { (localeCode) in
			
			let locale = Locale(identifier: "en_US")
			guard let countryName = locale.localizedString(forRegionCode: localeCode) else { return }
			
			let action = UIAlertAction(title: countryName, style: .default, handler: { (action) in
				self.presenter?.localeCode = localeCode
				
			})
			alert.addAction(action)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		self.present(alert, animated: true, completion: nil)
	}
	
	@objc func logOutButtonPressed() {
		
		presenter?.logOutRequest(with: { [weak self] (status, message) in
			DispatchQueue.main.async {
				if status {
					UserDefaults.standard.removeObject(forKey: "Token")
					let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
					appDelegate.setRootViewController()
				} else {
					self?.showAlertController(message: message)
				}
			}
		})
	}
	
	@objc func changeLocale() {
		showActionSheet()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.dataSource.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResultTableViewCell.self), for: indexPath) as! ResultTableViewCell
		cell.configure(data: presenter?.dataSource[indexPath.row])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}
}

// MARK: - ResultsTableViewDelegate
extension ResultsTableViewController: ResultsTableViewDelegate {
	
	func tableViewReloadData() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
}
