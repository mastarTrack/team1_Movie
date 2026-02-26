//
//  LoginViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
}
