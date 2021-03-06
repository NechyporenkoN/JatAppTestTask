//
//  SignupTableDelegates.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol SignupTablePresenterDelegate: class {
	
	var dataSource: [LoginCellType] { get }
	func signupRequest(name: String, email: String, password: String, with completion: Completion) 
}

protocol SignupTableViewDelegate: class {
	
}
