//
//  LoginView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 커스텀 버튼, TextField 만들기 - 완료

import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func didTapSignUpButton()
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let emailField = CustomTextField(placeholder: "email을 입력하세요.")
    private let passwordField = CustomTextField(placeholder: "password를 입력하세요.", isPassword: true)
    private let loginButton = CustomButton(title: "로그인")
    private let signUpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    private func setAttributes() {
        
        titleLabel.text = "Movie Booking"
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center

        
        subtitleLabel.text = "영화 예매를 쉽고 편리하게"
        subtitleLabel.textColor = .systemGray2
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        
        signUpButton.setTitle("계정이 없으신가요? 회원가입", for: .normal)
        signUpButton.setTitleColor(.systemOrange, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14)
        signUpButton.titleLabel?.textAlignment = .center
        
    }
    private func setLayout() {
        
        [titleLabel, subtitleLabel, emailField, passwordField, loginButton, signUpButton ].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
}

extension LoginView {
    private func setAction() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func signUpButtonTapped() {
        delegate?.didTapSignUpButton()
    }
}
