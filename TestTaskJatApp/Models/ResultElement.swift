//
//  ResultElement.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 13.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

class ResultElement {
	
	var character: String
	var number: Int?
	
	init(character: String, number: Int?) {
		self.character = character
		self.number = number
	}
}
