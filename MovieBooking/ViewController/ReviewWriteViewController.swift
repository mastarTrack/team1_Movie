//
//  ReviewWriteViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReviewWriteViewController: UIViewController {
    
    var reservationData: Reservation?
    
    private let reviewWriteView = ReviewWriteView()
    
    override func loadView() {
        self.view = reviewWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ReviewWriteViewController {
    private func setup() {
        if let data = reservationData {
            reviewWriteView.config(data: data)
        }
    }
}
