//
//  ResultsTablePresenter.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 12.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

final class ResultsTablePresenter {
	
	private weak var view: ResultsTableViewDelegate?
	private var dictChar: [String: Int] = [:]
	var dataSource: [ResultElement] = []
	var localeCode = "en_US" { didSet { getTextRequest(locale: localeCode, with: nil) }}
	
	init(view: ResultsTableViewDelegate) {
		self.view = view
		
		getTextRequest(locale: localeCode, with: nil)
	}
	
	private func configureDataSource() {
		
		dataSource.removeAll()
		dictChar.forEach { (character, number) in
			let element = ResultElement(character: character, number: number)
			dataSource.append(element)
		}
		dataSource = dataSource.sorted { $0.character < $1.character}
	}
	
	private func characterCounting(text: String) {
		
		dictChar.removeAll()
		let textArr = Array(text)
		var sortedArr = textArr.sorted {$0 < $1}
		var key = ""
		var value = 0
		
		for _ in 0..<sortedArr.count {
			let firstSimbol = sortedArr.removeFirst()
			if key != "" {
				if firstSimbol == Character(key) {
					key = String(firstSimbol)
					value += 1
				}
				else {
					dictChar.updateValue(value, forKey: key)
					key = ""
					value = 0
				}
			}
			if key == "" {
				key = String(firstSimbol)
				value += 1
			}
		}
		configureDataSource()
		view?.tableViewReloadData()
	}
	
	private func getTextRequest(locale: String, with completion: Completion) {
		
		guard let token = UserDefaults.standard.string(forKey: "Token"), var urlComponents = URLComponents(string: Routes.getTextRequest.url.absoluteString) else { return }
		
		urlComponents.queryItems = [URLQueryItem(name: "locale", value: locale)]
		urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "?")
		var request = URLRequest(url: urlComponents.url!)
		request.httpMethod = HttpMethod.get.rawValue
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
			
			if let error = error {
				completion?(false, String(describing: error))
			}
			
			if let data = data {
				
				if let jsonDict = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
					
					if let strData = jsonDict["data"] as? String {
						
						completion?(true, strData)
					
						self?.characterCounting(text: strData)
					}
						
					else if let jsonError = jsonDict["errors"] as? [NSDictionary] {
						
						let message = jsonError.first?["message"] as? String
						
						completion?(true, message)
					}
				}
			}
		}
		task.resume()
	}
}

// MARK: - ResultsTablePresenterDelegate
extension ResultsTablePresenter: ResultsTablePresenterDelegate {
	
	func logOutRequest(with completion: Completion) {
		var request = URLRequest(url: Routes.signupRequest.url)
		request.httpMethod = HttpMethod.post.rawValue
		
		let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			if let error = error {
				completion?(false, String(describing: error))
			}
			
			if let data = data {
				
				if let jsonDict = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
					
					if let jsonError = jsonDict["errors"] as? [NSDictionary] {
						
						let message = jsonError.first?["message"] as? String
						
						completion?(true, message) //Password cannot be blank. ???
						
					} else {
						
						let strData = jsonDict["data"] as? String
						
						completion?(true, strData)
					}
				}
			}
		}
		task.resume()
	}
}
