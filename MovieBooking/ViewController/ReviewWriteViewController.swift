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
        reviewWriteView.textView.delegate = self
        reviewWriteView.delegate = self
    }
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
}

extension ReviewWriteViewController: ReviewWriteViewDelegate {
    func didTapWriteButton() {
        let rating = reviewWriteView.getStarCount()
        let content = reviewWriteView.getReviewText()
        
        guard let reservation = reservationData else { return }
        
        let status = CoreDataManager.shared.saveReview(reservation: reservation, content: content, rating: rating)
        
        if status {
            showCompletionAlert()
        } else {
            showErrorAlert()
        }
    }
}

extension ReviewWriteViewController {
    private func showCompletionAlert() {
        let alert = UIAlertController(title: "완료", message: "저장이 완료되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alert, animated: true)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "오류", message: "저장에 실패했습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
