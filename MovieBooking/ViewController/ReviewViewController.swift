//
//  ReviewViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private let reviewView = ReviewCollectionView()
    private let viewModel = ReviewViewModel()
    
    override func loadView() {
        self.view = reviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        bind()
        loadAllData()
    }
}

extension ReviewViewController {
    private func bind() {
        viewModel.onUpdated = { [weak self] in
            self?.reviewView.collectionView.reloadData()
        }
    }
}

extension ReviewViewController {
    private func setDelegate() {
        reviewView.delegate = self
        reviewView.collectionView.delegate = self
        reviewView.collectionView.dataSource = self
        
        reviewView.collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.id)
        reviewView.collectionView.register(AvailableReviewCollectionViewCell.self, forCellWithReuseIdentifier: AvailableReviewCollectionViewCell.id)
    }
}

extension ReviewViewController {
    
    private func loadAllData() {
        viewModel.loadData()
    }
}

extension ReviewViewController: ReviewCollectionViewDelegate {
    func didChangeSegment(index: Int) {
        viewModel.updateSelectedIndex(index: index)
    }
}


extension ReviewViewController: UICollectionViewDelegate {
    
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.selectedIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            let item = viewModel.getWrittenData(index: indexPath.item)
            cell.config(data: item)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailableReviewCollectionViewCell.id, for: indexPath) as? AvailableReviewCollectionViewCell else { return UICollectionViewCell() }
            let item = viewModel.getAvailableData(index: indexPath.item)
            cell.delegate = self
            cell.config(data: item)
            return cell
        }
    }
}

extension ReviewViewController: AvailableReviewCollectionViewCellDelegate {
    func didTapWriteButton(cell: AvailableReviewCollectionViewCell) {
        guard let indexPath = reviewView.collectionView.indexPath(for: cell) else { return }
        
        let reservation = viewModel.getAvailableData(index: indexPath.item)
        showReviewModal(data: reservation)
    }
    
    private func showReviewModal(data: Reservation) {
        
        let reviewWriteVM = ReviewWriteViewModel(reservation: data)
        let reviewWriteVC = ReviewWriteViewController()
        reviewWriteVC.viewModel = reviewWriteVM
        
        reviewWriteVC.delegate = self
        
        reviewWriteVC.modalPresentationStyle = .pageSheet
        self.present(reviewWriteVC, animated: true)
    }
}

extension ReviewViewController: ReviewWriteViewControllerDelegate {
    func didFinishReviewWrite() {
        viewModel.loadData()
    }
}

