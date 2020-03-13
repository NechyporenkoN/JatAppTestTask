//
//  SignupTablePresenter.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

final class SignupTablePresenter {
	
	private weak var view: SignupTableViewDelegate?
	
	var dataSource: [LoginCellType] = []
	
	init(view: SignupTableViewDelegate) {
		self.view = view
		configureDataSource()
	}
	
	private func configureDataSource() {
		dataSource = [.name, .email, .password, .signup]
	}
}

// MARK: - SignupTablePresenterDelegate
extension SignupTablePresenter: SignupTablePresenterDelegate {
	
	func signupRequest(name: String, email: String, password: String, with completion: Completion) {
		
		var request = URLRequest(url: Routes.signupRequest.url)
		request.httpMethod = HttpMethod.post.rawValue
		
		let postString = "name=\(name)&email=\(email)&password=\(password)"
		request.httpBody = postString.data(using: String.Encoding.utf8)
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			if let error = error {
				completion?(false, String(describing: error))
			}
			
			if let data = data {
				
				if let jsonDict = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
					
					let jsonData = jsonDict["data"] as? NSDictionary
					
					if let token = jsonData?["access_token"] as? String {
						
						UserDefaults.standard.set(token, forKey: "Token")
						
						completion?(true, nil)
						
					} else {
						
						let jsonError = jsonDict["errors"] as? [NSDictionary]
						
						let message = jsonError?.first?["message"] as? String
						
						completion?(false, message)
					}
				}
			}
		}
		task.resume()
	}
}
