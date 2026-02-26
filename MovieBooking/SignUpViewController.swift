//
//  SignUpViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let singUpView = SignUpView()
    
    override func loadView() {
        self.view = singUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
