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
    let seatViewModel = SeatSelectionViewModel()
    private let ticketBookingViewModel: TicketBookingViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "좌석 선택"
        
        seatViewModel.setMaxSelectableCount(
            ticketBookingViewModel.adultCount + ticketBookingViewModel.childCount
        )
        
        view.addSubview(seatView)
        seatView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        setupViewModel()
        bindViewModel()
        bindView()
    }
    
    // 아예 뷰모델 넘겨주기
    init(ticketBookingViewModel: TicketBookingViewModel) {
        self.ticketBookingViewModel = ticketBookingViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 예매된 좌석 임의로 추가
    private func setupViewModel() {
        seatViewModel.setup(
            totalSeatsCount: seatView.totalSeatsCount,
            unavailableIndexes: [3,6,100]
        )
    }
    
    // 뷰모델에서 뷰에 받아오는거
    private func bindViewModel() {
        // 시트가 바뀌면 어떤걸 해야하는지
        seatViewModel.onSeatStateChanged = { [weak self] index in
            guard let self else { return }
            let state = self.seatViewModel.seatStates[index]
            self.seatView.updateSeatState(index: index, state: state)
        }
        // 시트가 선택되면 작동할 코드
        seatViewModel.onSelectionChanged = { [weak self] titles in
            self?.seatView.guideLabel.text =
            titles.isEmpty ? "좌석을 선택하세요." :
            "선택: \(titles.joined(separator: " "))"
        }
        // 시트를 제한된 좌석수에 다달았을때
        seatViewModel.onLimitReached = { [weak self] max in
            self?.seatView.guideLabel.text = "\(max)개의 좌석만 선택할 수 있습니다."
        }
    }
    
    // 뷰에서 뷰모델 받아오는거
    private func bindView() {
        // 뷰에서 시트 눌렸을때 해당 좌석 정보 뷰모델로 보내기
        seatView.onSeatTapped = { [weak self] index, title in
            self?.seatViewModel.updateSeatState(index: index, title: title)
        }
        
        //여기서 그냥 저장도 함
        seatView.reservationButton.addAction(
            UIAction { [weak self] _ in
                self?.didTapReservation()
            },
            for: .touchUpInside
        )
    }
    
    private func didTapReservation() {
        // 1) 좌석 문자열 가져오기
        let seats = seatViewModel.selectedSeatsForSave
        
        // 좌석을 하나도 안 골랐으면 막기
        guard seats.isEmpty == false else {
            showSimpleAlert(title: "좌석 선택", message: "좌석을 선택해주세요.")
            return
        }
        
        // 2) TicketBookingViewModel에 좌석 저장
        ticketBookingViewModel.setSelectedSeats(seats)
        
        // 3) CoreData 저장 + 결과 받기
        ticketBookingViewModel.bookReservation { [weak self] success in
            guard let self else { return }
            self.showBookingResult(success: success)
        }
    }
    
    private func showBookingResult(success: Bool) {
        let title = success ? "예매 완료" : "예매 실패"
        let message = success ? "예매가 완료되었습니다." : "예매에 실패했습니다."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }
            if success {
                // 현재 화면(SeatSelectionVC)이 pop → TicketBookingVC로 돌아감
                self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }
    
    
    private func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
