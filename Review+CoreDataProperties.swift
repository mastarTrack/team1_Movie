//
//  Review+CoreDataProperties.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//
//

public import Foundation
public import CoreData


public typealias ReviewCoreDataPropertiesSet = NSSet

extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var rating: Int16
    @NSManaged public var reservation: Reservation?

}

extension Review : Identifiable {

}
