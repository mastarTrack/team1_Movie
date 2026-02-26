//
//  CustomTextField.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit
import SnapKit

class CustomTextField: UIView {
    let textField = UITextField()
    
    init(placeholder: String, isPassword: Bool = false) {
        super.init(frame: .zero)
        setAttributes(placeholder: placeholder, isSecure: isPassword)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextField {
    private func setAttributes(placeholder: String, isSecure: Bool) {
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        
    }
    private func setLayout() {
        
        addSubview(textField)
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview()
        }
    }
}
