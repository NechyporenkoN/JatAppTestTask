//
//  Routes.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 12.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import Foundation

var domain: String {
	"http://apiecho.cf/api/"
}

enum Routes {
	case loginRequest
	case signupRequest
	case getTextRequest

	var url: URL {
		switch self {
		case .loginRequest: return URL(string: "\(domain)login/")!
		case .signupRequest: return URL(string: "\(domain)signup/")!
		case .getTextRequest: return URL(string: "\(domain)get/text/")!
		}
	}
}
