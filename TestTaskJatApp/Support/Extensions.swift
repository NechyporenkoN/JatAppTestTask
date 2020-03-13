//
//  Extensions.swift
//  TestTaskJatApp
//
//  Created by Nikita Nechyporenko on 11.03.2020.
//  Copyright © 2020 Nikita Nechyporenko. All rights reserved.
//

import UIKit

extension UIView {
	
	func shake(for duration: TimeInterval = 0.35, withTranslation translation: CGFloat = 7) {
		
		let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
		notificationFeedbackGenerator.prepare()
		
		
		let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
			self.transform = CGAffineTransform(translationX: translation, y: 0)
		}
		
		propertyAnimator.addAnimations({
			self.transform = CGAffineTransform(translationX: 0, y: 0)
		}, delayFactor: 0.2)
		
		propertyAnimator.startAnimation()
		notificationFeedbackGenerator.notificationOccurred(.error)
	}
}
