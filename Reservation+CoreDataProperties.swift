//
//  Reservation+CoreDataProperties.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
//

public import Foundation
public import CoreData


public typealias ReservationCoreDataPropertiesSet = NSSet

extension Reservation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reservation> {
        return NSFetchRequest<Reservation>(entityName: "Reservation")
    }

    @NSManaged public var title: String?
    @NSManaged public var watchTime: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var id: UUID?
    @NSManaged public var watchDate: String?
    @NSManaged public var reservationDate: String?
    @NSManaged public var theaterName: String?
    @NSManaged public var adult: Int16
    @NSManaged public var child: Int16
    @NSManaged public var totalPrice: Int64
    @NSManaged public var userEmail: String?
    @NSManaged public var seatNumber: String?
    @NSManaged public var review: Review?

}

extension Reservation : Identifiable {

}
