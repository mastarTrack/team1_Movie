//
//  SeatSelectionViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/5/26.
//
import UIKit
import SnapKit

final class SeatSelectionViewController: UIViewController {
    private let seatView = SeatSelectionView()
    let viewModel = SeatSelectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "좌석 선택"
        
        view.addSubview(seatView)
        seatView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        setupViewModel()
        bindViewModel()
        bindView()
    }
    
    private func setupViewModel() {
        viewModel.setup(
            totalSeatsCount: seatView.totalSeatsCount,
            unavailableIndexes: [3,6,100]
        )
        viewModel.setMaxSelectableCount(4)
    }
    
    // 뷰모델에서 뷰에 받아오는거
    private func bindViewModel() {
        // 시트가 바뀌면 어떤걸 해야하는지
        viewModel.onSeatStateChanged = { [weak self] index in
            guard let self else { return }
            let state = self.viewModel.seatStates[index]
            self.seatView.updateSeatState(index: index, state: state)
        }
        // 시트가 선택되면 작동할 코드
        viewModel.onSelectionChanged = { [weak self] titles in
            self?.seatView.guideLabel.text =
            titles.isEmpty ? "좌석을 선택하세요." :
            "선택: \(titles.joined(separator: " "))"
        }
        // 시트를 제한된 좌석수에 다달았을때
        viewModel.onLimitReached = { [weak self] max in
            self?.seatView.guideLabel.text = "\(max)개의 좌석만 선택할 수 있습니다."
        }
    }
    
    // 뷰에서 뷰모델 받아오는거
    private func bindView() {
        // 뷰에서 시트 눌렸을때 해당 좌석 정보 뷰모델로 보내기
        seatView.onSeatTapped = { [weak self] index, title in
            self?.viewModel.updateSeatState(index: index, title: title)
        }
        
        // 예매하기 버튼 액션 등록
        seatView.reservationButton.addAction(
            UIAction { [weak self] _ in
                self?.didTapReservation()
            },
            for: .touchUpInside
        )
    }
    
    private func didTapReservation() {
        let seats = viewModel.selectedSeatsForSave
        print("저장할 좌석:", seats)
        // CoreData 저장 로직 VM에서 구현해서 여기로 옮겨야함
    }
}
