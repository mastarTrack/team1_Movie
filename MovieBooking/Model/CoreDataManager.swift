//
//  CoreDataManager.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

//TODO: 로그인 로직 수정(로그인 시 Bool 반환 -> User 반환) userDefaults name 저장용 - 완료
//TODO: 로그인 성공 케이스 구분 enum 생성 - 완료

import UIKit
import CoreData

enum LoginResult {
    case success(User)
    case userNotFound
    case passwordError
    case serverError
}

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieBooking")
        container.loadPersistentStores { _, error in
            if let error = error { fatalError("CoreData Error: \(error)")}
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// 회원정보 Entity 관련
extension CoreDataManager {
    func saveUser(name: String, email: String, password: String) -> Bool {
        let user = User(context: context)
        user.name = name
        user.email = email
        user.password = password
        
        do {
            try context.save()
            print("이름: \(name), email: \(email), 비밀번호: \(password) 저장 완료")
            return true
        } catch {
            print("저장 실패")
            return false
        }
    }
    
    // 없을 경우 true, 있을 경우 false, 조회 실패일 경우 nil
    func isUserExist(email: String) -> Bool? {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            return nil
        }
    }
    
    func login(email: String, password: String) -> LoginResult {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            let users = try context.fetch(fetchRequest)
            guard let user = users.first else {
                return .userNotFound
            }
            if user.password == password {
                return .success(user)
            } else {
                return .passwordError
            }
        } catch {
            return .serverError
        }
    }
}

extension CoreDataManager {
    func saveReservation(
        title: String?,
        posterPath: String?,
        theaterName: String?,
        watchDate: String?,
        watchTime: String?,
        adult: Int,
        child: Int,
        totalPrice: Int,
        seatNumber: String? = nil,
        userEmail: String? = nil
    ) -> Bool {
        
        let reservation = Reservation(context: context)
        reservation.id = UUID()
        reservation.title = title
        reservation.posterPath = posterPath
        reservation.theaterName = theaterName
        reservation.watchDate = watchDate
        reservation.watchTime = watchTime
        reservation.adult = Int16(adult)
        reservation.child = Int16(child)
        reservation.totalPrice = Int64(totalPrice)
        reservation.seatNumber = seatNumber
        reservation.userEmail = userEmail
        
        // 예매한 날짜 저장하기
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        reservation.reservationDate = formatter.string(from: Date())
        
        do {
            try context.save()
            return true
        } catch {
            print("저장 실패")
            return false
        }
    }
}
