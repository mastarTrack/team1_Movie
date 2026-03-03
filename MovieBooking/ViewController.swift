//
//  ViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//MARK: 임시용 로그아웃 버튼 생성 - 완료

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let logoutButton = CustomButton(title: "로그아웃")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLogoutButton()
    }
}

extension ViewController {
    private func setLogoutButton() {
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(150)
        }
    }
    @objc
    private func logoutButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
