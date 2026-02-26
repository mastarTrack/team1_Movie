//
//  LoginView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 커스텀 버튼, TextField 만들기

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let signUpLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    private func setAttributes() {
        
        titleLabel.text = "Movie Booking"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "영화 예매를 쉽고 편리하게"
        subtitleLabel.textColor = .systemGray2
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textAlignment = .center
        
        [emailField, passwordField].forEach {
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 16)
            $0.backgroundColor = .systemGray2
            $0.textAlignment = .left
            
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
            
        }
        
        emailField.placeholder = "email 입력하세요."
        passwordField.placeholder = "password 입력하세요."
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemOrange
        loginButton.titleLabel?.textAlignment = .center
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        
        
        signUpLabel.text = "계정이 없으신가요? 회원가입"
        signUpLabel.textColor = .systemOrange
        signUpLabel.textAlignment = .center
        
    }
    private func setLayout() {
        
        [titleLabel, subtitleLabel, emailField, passwordField, loginButton, signUpLabel ].forEach { addSubview($0) }
        
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
            $0.top.equalTo(passwordField.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        signUpLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
    }
}
