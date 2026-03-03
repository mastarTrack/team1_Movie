//
//  UIStackView+.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/2/26.
//
import UIKit

extension UIStackView {
    static func vertical(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fill
        arrangedSubviews.forEach { stack.addArrangedSubview($0) }
        return stack
    }

    static func horizontal(_ arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fill
        arrangedSubviews.forEach { stack.addArrangedSubview($0) }
        return stack
    }
}
