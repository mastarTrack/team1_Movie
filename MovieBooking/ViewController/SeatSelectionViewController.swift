//
//  SeatSelectionViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/5/26.
//
import UIKit
import SnapKit

final class SeatSelectionViewController: UIViewController {
    private let seatSelectionView = SeatSelectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "좌석 선택"

        view.addSubview(seatSelectionView)
        seatSelectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
