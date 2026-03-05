//
//  ReviewWriteViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReviewWriteViewController: UIViewController {
    
    private let reviewWriteView = ReviewWriteView()
    var viewModel: ReviewWriteViewModel?
    
    override func loadView() {
        self.view = reviewWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
}

extension ReviewWriteViewController {
    private func bind() {
        viewModel?.onSaveResult = { [weak self] status in
            if status {
                self?.showCompletionAlert()
            } else {
                self?.showSaveErrorAlert()
            }
        }
        viewModel?.onValidError = { [weak self] message in
            self?.showValidErrorAlert(message: message)
        }
    }
}

extension ReviewWriteViewController {
    private func setup() {
        if let data = viewModel?.movieInfo {
            reviewWriteView.config(title: data.title, date: data.date, posterPath: data.posterPath)
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
        viewModel?.rating = reviewWriteView.getStarCount()
        viewModel?.content = reviewWriteView.getReviewText()
        viewModel?.saveReview()
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
    
    private func showSaveErrorAlert() {
        let alert = UIAlertController(title: "오류", message: "저장에 실패했습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    private func showValidErrorAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
