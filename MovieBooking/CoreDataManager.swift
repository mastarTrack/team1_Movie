//
//  CoreDataManager.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/26/26.
//

import UIKit
import CoreData

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
}
