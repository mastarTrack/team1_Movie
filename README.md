
=======
# 🎬 MovieBooking App

영화 정보를 확인하고 예매까지 진행할 수 있는 **iOS 영화 예매 앱**입니다.  
TMDB API를 활용해 영화 데이터를 가져오고, CoreData를 통해 예매 정보를 저장하도록 구현했습니다.

---

# 📱 프로젝트 소개

이 프로젝트는 iOS에서 실제 영화 예매 서비스의 흐름을 간단하게 구현하는 것을 목표로 합니다.

사용자는 다음과 같은 기능을 사용할 수 있습니다.

- 현재 상영 중 / 인기 / 개봉 예정 영화 조회
- 영화 상세 정보 확인
- 영화 예매 진행
- 좌석 선택
- 예매 정보 저장

|로그인|첫 화면|
|------|---|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 24 44" src="https://github.com/user-attachments/assets/608696d0-9810-4f98-9fbf-d98833402a5a" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 18 22" src="https://github.com/user-attachments/assets/8df1d4a0-e671-44b4-bcd4-ea06306e5396" />|

|검색페이지|상세페이지|
|------|---|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 18 33" src="https://github.com/user-attachments/assets/f54f5c9f-65e2-492d-96e3-485a87f395e3" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 19 05" src="https://github.com/user-attachments/assets/7bfb463a-5c50-4426-9a44-f51bb32f786e" />|

|마이페이지|환경설정|
|------|---|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 18 39" src="https://github.com/user-attachments/assets/1c72dea3-4de5-483e-889d-dad15c57a703" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 21 43" src="https://github.com/user-attachments/assets/f02eb417-ca3a-4f63-aed9-092577a05dab" />|

|예매페이지|좌석 선택|
|------|---|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 19 48" src="https://github.com/user-attachments/assets/aae30d4c-dea7-4433-9633-4cd3f09fe427" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 19 59" src="https://github.com/user-attachments/assets/1baae2f3-a501-48a8-adce-28b7957ab241" />|

|리뷰작성페이지|예매내역&리뷰페이지|
|------|---|
|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 20 56" src="https://github.com/user-attachments/assets/a80a58b4-9afa-4242-a39d-e55c91f21139" />|<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-06 at 11 20 39" src="https://github.com/user-attachments/assets/aea1f326-62f2-457f-93da-eaa5bdaf9ef4" />|







# 🛠 Tech Stack

| 기술 | 설명 |
|---|---|
| UIKit | iOS UI 구성 |
| MVVM | View와 비즈니스 로직 분리 |
| SnapKit | AutoLayout 코드 기반 작성 |
| CoreData, UserDefaults | 데이터 저장 |
| Kingfisher | 이미지 비동기 다운로드 및 캐싱 |
| TMDB API | 영화 데이터 제공 |
| URLSession | 네트워크통신 |

---

# 🏗 Architecture

## MVVM (Model - View - ViewModel)

이 프로젝트는 **MVVM 아키텍처 패턴**을 기반으로 구현되었습니다.

## 📁 Project Structure
```
├── Config.xcconfig
├── MovieBooking
│   ├── Model
│   ├── Network
│   ├── Util
│   ├── View
│   ├── ViewController
│   └── ViewModel
└── README.md
```

---
# 🔑 핵심 구현 내용

### 1. 로그인 / 회원가입 화면
- 앱 진입 시 로그인 화면이 먼저 나타나도록 구성했습니다.
- 회원가입 화면에서 아이디와 비밀번호를 입력받아 계정을 생성할 수 있도록 구현했습니다.
- 로그인 완료 시 `UserDefaults`에 아이디와 비밀번호를 저장하여, 이후 앱 실행 시 자동으로 입력되도록 처리했습니다.
- 아이디와 비밀번호 입력값에 대해 유효성 검사를 적용하여 올바른 형식으로만 회원가입 및 로그인이 가능하도록 했습니다.
- 로그인 성공 후 TabBar 기반 메인 화면으로 이동하도록 흐름을 설계했습니다.

### 2. 영화 목록 페이지
- TabBar의 첫 번째 화면으로, TMDB API를 통해 영화 목록 데이터를 가져오도록 구현했습니다.
- `UICollectionView`를 활용해 영화 포스터를 가로 스크롤 형태로 표시했습니다.
- 현재 상영작, 인기 영화, 개봉 예정작 등 여러 영화 목록을 화면에 구성할 수 있도록 설계했습니다.
- 사용자가 포스터를 선택하면 영화 상세 화면으로 이동할 수 있도록 연결했습니다.

### 3. 영화 세부 페이지
- 영화 목록 또는 검색 결과에서 특정 영화를 선택하면 상세 페이지로 이동하도록 구현했습니다.
- 영화 포스터, 제목, 장르, 개봉일, 줄거리 등 주요 정보를 화면에 표시했습니다.
- 선택한 영화 정보를 다음 예매 화면으로 자연스럽게 전달할 수 있도록 데이터 흐름을 구성했습니다.

### 4. 영화 예매 입력 페이지
- 영화 상세 페이지에서 예매 버튼을 누르면 예매 입력 화면으로 이동하도록 구현했습니다.
- 영화관, 날짜, 시간, 인원 수, 좌석 등 예매에 필요한 정보를 입력할 수 있도록 구성했습니다.
- 결제하기 버튼을 누르면 예매 내역이 저장되고, 이후 마이페이지에서 확인할 수 있도록 연결했습니다.
- 예매 과정에서 선택한 데이터를 기반으로 화면 상태를 갱신하도록 구현했습니다.

### 5. 영화 검색 페이지
- TabBar의 두 번째 화면으로, 사용자가 입력한 텍스트를 기준으로 영화를 검색할 수 있도록 구현했습니다.
- 검색 결과는 `UICollectionView`를 활용해 영화 포스터 형태로 표시했습니다.
- 검색어를 포함한 영화 데이터를 API에서 받아와 화면에 반영하도록 구성했습니다.
- 검색 결과에서 영화를 선택하면 상세 페이지로 이동할 수 있도록 연결했습니다.

### 6. 마이페이지
- TabBar의 세 번째 화면으로, 사용자 계정 정보와 예매 내역을 확인할 수 있도록 구성했습니다.
- 회원가입 시 입력한 사용자 정보를 표시할 수 있도록 `UserDefaults` 기반으로 데이터를 관리했습니다.
- 사용자가 결제한 영화 예매 내역을 확인할 수 있도록 저장 및 조회 기능을 구현했습니다.
- 사용자 정보와 예매 내역을 한 화면에서 확인할 수 있도록 마이페이지 구조를 설계했습니다.
---

# 회고
### 겪언던 문제점
- 장예슬: 이미 예매하기 창에서 데이터 저장까지 구현을 마쳤어서 추가기능으로 영화관 좌석뷰를 구현할때 데이터 흐름이 어려웠습니다.
- 손영빈: 레이아웃 구성을 어떻게 하는 게 좋을까에 대한 고민이 많았다. 또한, "Entity의 Attribute 설정을 잘못했을 때, 어떻게 수정을 해야할까?"와 "다른 Entity를 JOIN 하는 방법은 없을까?"를 생각해보았다.
### 목표대비 이룬점
- 장예슬: MVVM 구조를 적용하고 좌석 선택 및 예매 기능을 구현하여 실제 앱과 유사한 흐름을 완성했습니다!! 필수구현까지가 목표였지만 추가 구현까지 끝내서 기쁩니다
- 손영빈: CoreData를 설계하고 사용하면서 익숙해진 것 같다. 또한, MVVM도 지난 과제까지는 적용하기까지 시간이 꽤 오래걸렸는데, 아직 MVC -> MVVM으로 리팩토링하는 과정을 거치는 것이 더 편하긴 하지만, 수정하는 것에 있어 시간이 많이 단축되었다고 느꼈다.
### 소감
- 장예슬: MVVM구조와 CollectionView 공부가 많이 된 프로젝트였습니다!!
- 손영빈: 빠른 시일 내에 완성하여 보다 많은 도전 구현을 진행해보고자 했지만, 그러지 못한 것 같아 아쉽다. 그래도 CollectionView, CoreData, MVVM 구조 익숙해지기에 성공한 것 같다.
---

