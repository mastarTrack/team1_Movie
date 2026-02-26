//
//  CustomLoginButton.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit

class CustomLoginButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        setAttributes(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomLoginButton {
    private func setAttributes(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.titleLabel?.textAlignment = .center
        self.backgroundColor = .systemOrange
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
