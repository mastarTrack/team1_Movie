//
//  SeatSelectionView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/5/26.
//
import UIKit
import SnapKit
// 접근제어자 붙이기

final class SeatSelectionView: UIView {
    
    // VC 보낼것 좌석 인덱스랑 좌석 번호
    var onSeatTapped: ((Int, String) -> Void)?
    
    let titleLabel = UILabel()
    let guideLabel = UILabel() // 좌석 상태 안내
    let screenLabel = UILabel()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let reservationButton = CustomButton(title: "예매하기")
    
    // 좌석은 여기에 넣기
    let seatContainerView = UIView()
    let columns = 15
    let rows = 10
    let seatSize = CGSize(width: 40, height: 40)
    let spacing: CGFloat = 6
    lazy var totalSeatsCount = rows * columns // 150개
    var seatButtons = [UIButton]()
    
    // 좌석으로 크기 정하기
    lazy var containerWidth = CGFloat(columns) * seatSize.width + CGFloat(columns) * spacing + 40
    lazy var containerHeight = CGFloat(rows) * seatSize.height + CGFloat(rows) * spacing + 40
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureFixedView()
        configureSeatView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSeatView() {
        for index in 0..<totalSeatsCount {
            let button = UIButton()
            button.tag = index
            button.setTitle(seatTitle(index: index), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
            button.backgroundColor = .systemGray4
            button.layer.cornerRadius = 6
            
            // 뷰에 넣기
            seatContainerView.addSubview(button)
            
            // 버튼에 액션 등록하기
            button.addAction(UIAction { [weak self] _ in
                guard let self else { return }
                let title = self.seatTitle(index: index)
                self.onSeatTapped?(index, title)
            }, for: .touchUpInside)

            
            // CGFloat로 Grid 그리기
            let row = index / columns
            let column = index % columns
            let x = 20 + CGFloat(column) * (seatSize.width + spacing)
            let y = 20 + CGFloat(row) * (seatSize.height + spacing)
            button.frame = CGRect(x: x, y: y, width: seatSize.width, height: seatSize.height)
            
            // 이걸로 상태저장
            seatButtons.append(button)
        }
    }
    
    // 저장된 걸로 버튼 모양 바꾸기
    func updateSeatState(index: Int, state: SeatSelectionViewModel.SeatState) {
        let button = seatButtons[index]
        
        switch state {
        case .available:
            button.backgroundColor = .systemGray4
            button.isEnabled = true
        case .selected:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemOrange
            button.isEnabled = true
        case .Unavailable:
            button.backgroundColor = .systemGray
            button.setTitleColor(.clear, for: .normal)
            button.isEnabled = false
        }
    }
}


extension SeatSelectionView {
    private func configureFixedView() {
        titleLabel.text = "좌석 선택"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        guideLabel.text = "좌석을 선택하세요."
        guideLabel.textColor = .secondaryLabel
        guideLabel.font = .systemFont(ofSize: 13)
        
        screenLabel.text = "SCREEN"
        screenLabel.textAlignment = .center
        screenLabel.font = .boldSystemFont(ofSize: 14)
        screenLabel.textColor = .systemOrange
        screenLabel.backgroundColor = .systemGray5
        screenLabel.layer.cornerRadius = 10
        screenLabel.clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(guideLabel)
        addSubview(screenLabel)
        addSubview(reservationButton)
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(seatContainerView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel)
        }
        
        screenLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(32)
        }
        
        reservationButton.snp.makeConstraints {
            $0.width.equalTo(150)
            $0.height.equalTo(40)
            $0.top.equalTo(safeAreaInsets).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(screenLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        // 실제보여줄 크기
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(containerWidth)
            $0.height.equalTo(containerHeight)
        }

        seatContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func seatTitle(index: Int) -> String {
        // 몇번째 줄인지
        let rowIndex = index / columns
        // 몇번째 순서 인지
        let columnIndex = index % columns
        
        let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        guard rowIndex < alphabet.count else { return "오류" }
        
        //줄에 해당하는 알파벳 넣기
        let rowLetter = alphabet[rowIndex]
        let seatNumber = columnIndex
        
        return "\(rowLetter)\(seatNumber)"
    }
}

