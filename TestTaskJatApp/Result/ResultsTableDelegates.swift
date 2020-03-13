//
//  ResultsTableDelegates.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 12.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

protocol ResultsTablePresenterDelegate: class {
	
	var dataSource: [ResultElement] { get }
	var localeCode: String { get set }
	func logOutRequest(with completion: Completion)
}

protocol ResultsTableViewDelegate: class {
	
	func tableViewReloadData()
}
