//
//  City+CoreDataProperties.swift
//  
//
//  Created by Max Peiros on 9/27/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension City {

    @NSManaged var cityName: String?
    @NSManaged var temperature: String?
    @NSManaged var humidity: String?
    @NSManaged var windSpeed: String?
    @NSManaged var weatherDescription: String?
    @NSManaged var imageName: String?

}
