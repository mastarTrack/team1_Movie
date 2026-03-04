//
//  PasswordChangeViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/4/26.
//

import UIKit

class PasswordChangeViewController: UIViewController {
    
    private let passwordChangeView = PasswordChangeView()
    
    override func loadView() {
        self.view = passwordChangeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
