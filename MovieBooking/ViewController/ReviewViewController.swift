//
//  ReviewViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private let reviewView = ReviewCollectionView()
    
    private var selectedIndex = 0
    
    private var availableData: [Reservation] = []
    
    override func loadView() {
        self.view = reviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension ReviewViewController: ReviewCollectionViewDelegate {
    func didChangeSegment(index: Int) {
        self.selectedIndex = index
        reviewView.collectionView.reloadData()
    }
}


extension ReviewViewController: UICollectionViewDelegate {
    
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedIndex == 0 ? 1 : availableData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if selectedIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailableReviewCollectionViewCell.id, for: indexPath) as? AvailableReviewCollectionViewCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    
}
